---
title: "Порты и протоколы для AppSec — справочник"
description: "Справочник сетевых портов и протоколов для задач AppSec, DevSecOps и пентестинга: веб, базы данных, CI/CD, контейнеры."
keywords: "порты, протоколы, AppSec, DevSecOps, сканирование, Nmap, сетевая безопасность, TCP, UDP, справочник"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Порты и протоколы</h1>
    <p class="hero-sub">Справочник для AppSec-задач</p>
  </div>
</div>

## Веб-сервисы

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">80</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTP</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Веб-трафик без шифрования. MitM, перехват данных, подмена контента.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">443</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTPS</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Веб-трафик с TLS. Misconfigured TLS, expired certs, weak ciphers.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">8080</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTP Proxy</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Прокси, dev-серверы, Tomcat, Jenkins. Часто без аутентификации, information disclosure.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">8443</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTPS Alt</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Альтернативный HTTPS (Tomcat, API). Self-signed certs, те же риски что 443.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3000</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Dev server</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Grafana, Node.js dev, Gitea. Dev-инструменты на production — information disclosure.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">9090</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Prometheus</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Мониторинг метрик. Открытые метрики — утечка внутренней архитектуры.</p>
  </div>

</div>

---

## Базы данных

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3306</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · MySQL / MariaDB</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SQL Injection, brute-force credentials, data exfiltration.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5432</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · PostgreSQL</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SQL Injection, pg_dump data theft, weak <code>pg_hba.conf</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">27017</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · MongoDB</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">NoSQL Injection, default no-auth, data exposure.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">6379</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Redis</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default no-auth, RCE через <code>EVAL</code>, data theft.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">1433</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · MSSQL</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SQL Injection, <code>xp_cmdshell</code> RCE.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">9200</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Elasticsearch</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default no-auth, bulk data exposure, RCE через scripts.</p>
  </div>

</div>

---

## SSH и удалённый доступ

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">22</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · SSH</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Brute-force, weak keys, <code>PermitRootLogin</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3389</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · RDP</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">BlueKeep (CVE-2019-0708), brute-force, NLA bypass.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">23</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Telnet</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Plaintext credentials, MitM. Не должен быть открыт в production.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5900</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · VNC</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default no-auth, plaintext, screen capture.</p>
  </div>

</div>

---

## CI/CD и DevOps

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">2375</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Docker API</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CRITICAL</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Docker daemon без шифрования. Full host takeover — создание privileged container.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">6443</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Kubernetes API</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CRITICAL</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">RBAC misconfig, secret extraction, pod escape.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">10250</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Kubelet</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Unauthenticated exec в pods. K8s node agent.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5000</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Docker Registry</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">No-auth push/pull, image tampering.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">9000</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · SonarQube</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default credentials, source code exposure.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">2379</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · etcd</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">K8s key-value store. Cluster secrets, TLS certs, service accounts.</p>
  </div>

</div>

---

## DNS и сетевые сервисы

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">53</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/UDP · DNS</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">DNS spoofing, zone transfer (AXFR), cache poisoning.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">389</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · LDAP</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">LDAP Injection, plaintext bind, user enumeration.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">445</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · SMB</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">EternalBlue, ransomware propagation, null session.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">161</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">UDP · SNMP</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default community strings, information disclosure.</p>
  </div>

</div>

---

## Мониторинг и логирование

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3000</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Grafana</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default admin:admin, SSRF через data sources.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5601</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Kibana</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Default no-auth, sensitive log exposure.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">514</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">UDP · Syslog</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Log injection, plaintext.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5044</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · Logstash</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Pipeline manipulation.</p>
  </div>

</div>

---

## Nmap — быстрые команды

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Quick scan</div>
    <span class="lab-tag">top-1000</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>nmap -sV -sC -T4 &lt;target&gt;</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Full TCP + NSE</div>
    <span class="lab-tag">all ports</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>nmap -sV -sC -p- &lt;target&gt;</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">DevOps порты</div>
    <span class="lab-tag">CI/CD + K8s</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>nmap -sV -p 2375,2376,5000,6443,8080,9000,9090,10250 &lt;target&gt;</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">БД порты</div>
    <span class="lab-tag">databases</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>nmap -sV -p 1433,1521,3306,5432,6379,9200,27017 &lt;target&gt;</code></p>
  </div>

</div>
