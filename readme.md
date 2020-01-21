# linux/shell/script

## index

1. [**what is shellscript?**][i1]
2. [**scripts**][i2]
    1. [**apt_upgrade_and_clean**][i2-1]
    2. [**set_folder_files_name**][i2-2]
    3. [**dir_file_chmods**][i2-3]
    4. [**LV_mount_toggle**][i2-4]
    5. [**rsync_scripts.sh**][i2-5]
    6. [**rsync_local_to_partition**][i2-6]
3. [**linux shell api**][i3]

## what_is_shellscript
[i1]:#what_is_shellscript

1. shellscript?

```bash
#!/bin/sh

cd /var/backups || exit 0

for FILE in passwd group shadow gshadow; do
    test test -f /etc/$FILE || continue # -f FILE: FILE exits and is a regular file.
    cmp -s $FILE.bak /etc/$FILE || continue # compare two files byte to byte. --silent
    cp -p /etc/$FILE $FILE.bak && chmod 600 $FILE.bak #-p flag preserve=mode,ownership,timestamps.
done
```

* `[ -f /etc/passwd ] && echo yes || echo no`
* `test -f /etc/nopasswd && echo yes || echo no`

upper 2 is same. test is traditional expression interface, and [] bracket is newer one.

2. bash?

* on_going.

## scripts
[i2]:#scripts

### apt_upgrade_and_clean
[i2-1]:#apt_upgrade_and_clean

1. execute with sudo and no option.
2. update upgrade autoclean autoremove.
3. done.

### set_folder_files_name
[i2-2]:#set_folder_files_name

1. execute with sudo and no option.
2. insert path.
3. following files with path, name changes " " to "_".
4. done

### dir_file_chmods
[i2-3]:#dir_file_chmods

1. execute with sudo and 3 options(path, filename-keyword, modnumber).
2. `./dir_file_chmods.sh ~/myfiles/ .sh 744`
3. check working.
4. following files and your mod will be in check.
5. done

### LV_mount_toggle

[i2-4]:#LV_mount_toggle

1. execute with sudo and 1 option VGNAME.
2. get lv points from connected usb Volume Group(ie. `./LV_mount_toggle.sh vg_junehan_portable`).
3. start with create foldername `~/plugged_storage_YOURINPUT`.
4. press y to mount, n to umount else to pass.
5. if y? creates folder with LV name and mount. or n? umount and remove dir.
6. end with try remove dirname `~/plugged_storage_YOURINPUT`. if not empty? pass.
7. done

### rsync_scripts

[i2-5]:#rsync_scripts

1. execute with sudo and no option.
2. rsync will be happen to git directory. (symlink cannot be catched by git. rsync will be better than hard link or copy)
3. done

### rsync_local_to_partition

[i2-6]:#rsync_local_to_partition

1. execute with sudo and 1 option VGNAME to backup.
2. uses rsync to backup.
3. from `~/local_VGNAME`to `~/plugged_storage_VGNAME` will be rsync.
4. done

## linux_shell_api
[i3]:#linux_shell_api

### awk
[i3-1]:#awk

`awk [ -F fs] [ -v var=value ] ['prog' | -f progfile] [file ...]`

#### 텍스트를 분석하여 보고한다면

`Awk`는 각 입력파일을 별도의 패턴 prog에 따른 라인을 분석한다.  
입력파일의 각 라인을 순차적으로 패턴에 부합할 때 실행되는 액션이 존재할 수 있다.  
`-`라는 파일은 표준 입력을 의미한다. `var=value`같은 형식의 모든 파일은 파일명이 아닌 할당으로 취급되어,  
그것이 열렸어야 했던 시점부터 그것이 파일명이었던 것처럼 실행된다.  
옵션 `-v`는 `var=value` 에 붙어 오며, 그것은 prog가 실행되기 전에 끝나야 하는 것이다.  
`-F`,  fs옵션은 입력필드 seperator을 정규표현식인 `fs`로 선언한다.

입력 라인은 보통 공백으로 구성되어 있거나, 정규표현 FS로 구성된다.  
해당 필드들은 $1, $2, ... 등으로 표현되며, 반면 $0은 라인 전체를 가리킨다.  
만약 FS이 비어있다면, 입력문장은 캐릭터별로 하나의 필드로 분리된다.

패턴-액션은 아래와 같은 형식을 갖는다.

`pattern { action }`

action이 없다면 라인을 출력하라는 것이다. 패턴 액션은 또한 개행이나 세미콜론을 통해 분리된다.

```
if( expression ) statement [ else statement ]
while( expr ) statement
for( expr; expr; expr ) statement
for( var in array ) statement
do statement while( expr )
break
continue
{ [ statement ...] }
expr # commonly var = expr
print [ expr-list ] [ > expr ]
printf format [ , expr-list ] [ > expr ]
return [ expr ]
next # 남아있는 패턴을 이 입력라인에서는 생략한다.
nextfile # 이 파일의 나머지를 생략한다. 다음을 열고 맨 윗줄부터 시작한다.
delete array[ expr ] # 배열 요소를 삭제한다.
delete array # 배열의 모든 요소를 삭제한다.
exit [ expr ] # 즉시 종료한다. status는 expr이다.
```

진술문들은 세미콜론, 개행, 우측 대괄호에 의해 폐기된다.  비어있는 표현-리스트는 `$0`을 의미한다.  
문자 상수들은 " "에 감싸진다, 보통의 C  escapes가 인식되는 안에서.  
표현식들은 문자나 숫자형 값을 받으며 그들은 연산자들과 공백에 의해 알려지는 연쇄를 기초로 한다.

1. 20캐릭터 이상인 라인을 표준 출력으로 받으려면

```bash
awk 'length($0) > 20' tom.txt
```

2. 단어를 하나씩 기록하여 갯수와 해당 단어를 출력

```WordCount.awk
{
	for (i=1; i<=NF; i++)
	freq[$i]++
}

END {
	for (word in freq)
	printf "%s\t%d\n", word, freq[word]
}
```

```bash
awk -f WordCount.awk tom.txt
```

3. 두개의 필드를 역순으로 출력한다.

```bash
{ print $2, $1 }
```

4. 입력필드들을 콤마, 그리고 혹은 공백과 탭들로 분리한다.

```bash
BEGIN { FS = ",[ \t]*|[\t]+" }
	{ print $2, $1}
```

### sed
[i3-2]:#sed

#### 텍스트를 가공하고 수정하기 위하여

`sed` 는 특정하게 명시된 파일, 혹은 default로 표준 입력을 읽어내어 command의 리스트에 따라 수정한다.  
input은 이후 표준 출력으로 입력된다.

독립된 커맨드는 sed의 첫 인자로 처리될 수 있으나, 복수의 커맨드라면 `-e`, `-f`옵션을 통해 한번의 콜 수행에 옵션을 더한다.  

1. 가장 간단하게

```bash
echo "hello world" | sed s/world/JuneHan/
$hello junehan
```

