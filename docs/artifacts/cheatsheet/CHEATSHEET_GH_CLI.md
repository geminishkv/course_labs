---
hide:
  - toc
---

<div align="center">
<h1><a id="intro">CheatSheet</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

- gh actions

```bash
$ gh auth login
$ gh repo create repo_name # Cоздание удаленного репозитория (без URL)
$ gh repo clone user/repo

$ gh pr create --title "Название" --body "Описание" --base main --head feature-branch
	 --title # Заголовок PR
	 --body # Описание
	 --base # Целевая ветка
	 --head # Ваша ветка
	 —assignee «nickname» 
	 --source=
	 --public
	 --private
	 --base main 
	 --head feature-branch # Индивидуальный pull request (можно -a)

$ gh pr create --title "Bug" --body "work" $ gh pr create --base base_name # head changed_branch
$ gh pr merge --squash

$ gh issue list # Список открытых issue
$ gh repo view --web # Открыть репозитория в web
```

![Logo](../assets/logotypemd.jpg)