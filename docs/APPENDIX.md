---
hide:
  - toc
---

<table>
  <thead>
    <tr>
      <th style="width:15%;">Раздел</th>
      <th style="width:35%;">Описание</th>
      <th style="width:50%;">Основные элементы</th>
    </tr>
  </thead>
  <tbody>
      <tr>
      <td><strong>Указатели</strong></td>
      <td></td>
      <td>
        <ul>
          <li><code>HEAD</code> – указатель на текущий коммит или на текущую ветку (то есть, в любом случае, на коммит). Указывает на родителя коммита, который будет создан следующим</li>
          <li><code>ORIG_HEAD</code> – указатель на коммит, с которого вы только что переместили <code>~HEAD</code> (командой <code>git reset`</code> ..., например)</li>
          <li>Ветка<code>master, develop</code> и т.д. – указатель на коммит. При добавлении коммита, указатель ветки перемещается с родительского коммита на новый</li>
          <li><code>tags</code> – простые указатели на коммиты. Не перемещаются</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>ENV</strong></td>
      <td>Уровни конфигурации Git и соответствующие файлы.</td>
      <td>
        <ul>
          <li><code>--local</code> – локальный уровень, файл <code>.git/config</code></li>
          <li><code>--global</code> – пользовательский уровень, файл <code>~/.gitconfig</code></li>
          <li><code>--system</code> – системный уровень, файл <code>/etc/gitconfig</code></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Unix commands</strong></td>
      <td>Базовые утилиты командной строки семейства Unix.</td>
      <td>
        <ul>
          <li><a href="https://en.wikipedia.org/wiki/Ar_(Unix)">ar</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Cat_(Unix)">cat</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Cd_(command)">cd</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Cp_(Unix)">cp</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Cut_(Unix)">cut</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Echo_(command)">echo</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Env_(shell)">env</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Ex_(editor)">ex</a></li>
          <li><a href="https://en.wikipedia.org/wiki/File_(command)">file</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Find">find</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Ls">ls</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Man_page">man</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Mkdir">mkdir</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Mv">mv</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Nm_(Unix)">nm</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Ps_(Unix)">ps</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Pwd">pwd</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Rm_(Unix)">rm</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Sed">sed</a></li>
          <li><a href="https://en.wikipedia.org/wiki/Touch_(Unix)">touch</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Package managers</strong></td>
      <td>Системы управления пакетами и зависимостями.</td>
      <td>
        <ul>
          <li><a href="http://help.ubuntu.ru/wiki/apt">apt</a></li>
          <li><a href="https://en.wikipedia.org/wiki/DNF_(software)">dnf</a></li>
          <li><a href="https://fedoraproject.org/wiki/Yum/ru">yum</a></li>
          <li><a href="https://brew.sh">brew</a></li>
          <li><a href="http://linuxbrew.sh">linuxbrew</a></li>
          <li><a href="https://docs.npmjs.com">npm</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Software</strong></td>
      <td>Утилиты для работы с сетью и файлами.</td>
      <td>
        <ul>
          <li><a href="https://www.gitbook.com/book/bagder/everything-curl/details">curl</a></li>
          <li><a href="https://www.gnu.org/software/wget/manual/wget.pdf">wget</a></li>
          <li><a href="https://www.openssl.org">openssl</a></li>
          <li><a href="https://www.nano-editor.org">nano</a></li>
          <li><a href="https://linux.die.net/man/1/tree">tree</a></li>
          <li><a href="http://www.vim.org">vim</a></li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

![Логотип](artifacts/assets/logotypemd.jpg)