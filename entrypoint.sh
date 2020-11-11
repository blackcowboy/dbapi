#!/bin/bash
today=`date +"%Y%m%d"`

appdir="/aiops"
cron_1min="${appdir}/crontab/1min"
startapp="${appdir}/startapp.sh"

## �Զ�����ÿ����ִ�еĽű�Ŀ¼
[ -d ${cron_1min} ] || mkdir -p ${cron_1min} || { \
    echo "**********  ERROR  **********"; \
    echo "mkdir ${cron_1min} failed."; \
    echo "use [tail -f /dev/null] for container."; \
    tail -f /dev/null; \
}

## ���ű�Ŀ¼��ӵ�ϵͳ��crontab��
res=$(grep "${cron_1min}" /var/spool/cron/crontabs/root)
if [ -z "${res}" ]; then
    echo "*/1     *       *       *       *       run-parts ${cron_1min}" >> /var/spool/cron/crontabs/root
fi

## Ѱ��Ӧ�������ű�����û��Ӧ�������ű�����ʹ��Ĭ�ϵ�tail -f����
[ -s ${startapp} ] && source ${startapp}
echo "**********  ERROR  **********"
echo "[${startapp}] not exist or [${startapp}] has errors."
echo "use [tail -f /dev/null] for container."
tail -f /dev/null
