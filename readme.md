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
3. [**options**][i3]

## what_is_shellscript
[i1]: #what_is_shellscript

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
[i2]: #scripts

### apt_upgrade_and_clean
[i2-1]: #apt_upgrade_and_clean

1. execute with sudo and no option.
2. update upgrade autoclean autoremove.
3. done.

### set_folder_files_name
[i2-2]: #set_folder_files_name

1. execute with sudo and no option.
2. insert path.
3. following files with path, name changes " " to "_".
4. done

### dir_file_chmods
[i2-3]: #dir_file_chmods

1. execute with sudo and 3 options(path, filename-keyword, modnumber).
2. `./dir_file_chmods.sh ~/myfiles/ .sh 744`
3. check working.
4. following files and your mod will be in check.
5. done

### LV_mount_toggle

[i2-4]: #LV_mount_toggle

1. execute with sudo and no options.
2. get lv points from connected usb Volume Group(my_VG).
3. press y to mount, n to umount else to pass.
4. done

### rsync_scripts

[i2-5]: #rsync_scripts

1. execute from origin.
2. rsync will be happen to git directory. (symlink cannot be catched by git. rsync will be better than hard link or copy)
3. done

### rsync_local_to_partition

[i2-6]: #rsync_local_to_partition

1. execute with sudo and 1 option VGNAME to backup.
2. uses rsync to backup.
3. from VGNAME_local to VGNAME_partitions will be rsync.
4. done

## options
[i3]: options


