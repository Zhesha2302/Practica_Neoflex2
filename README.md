## Задание по Big Data
1.  Познакомится с экосистемой Big Datа. Запустить локальный экземпляр Hadoop Distributed File System (HDFS) на ноутбуке или ПК.
2.  Придумать каждый свою базу данных на любую тему и реализовать в Hadoop.
3.  * Сделать 3 модели данных: звезда, снежинка, Data Vault.
## Выполнение задания
Задание выполнено с помощью Docker.  
Запустила Docker и командную строку.  
Чтобы скачать образ и запустить контейнер ввела в командную строку.  

docker run -it -p 9870:9870 -p 8088:8088 -p 9864:9864 --name hadoop-cluster jporeilly/apache-hadoop:amd  

Началась загрузка.  
<img width="1478" height="808" alt="1" src="https://github.com/user-attachments/assets/98da8bd0-cb62-4585-a36b-96d6bebd81f7" />

Службы Hadoop не стартовали автоматически, поэтому запускаю вручную.  
Ищу Hadoop во всей файловой системе.  

find / -name "hadoop" -type d 2>/dev/null

Нашла в /usr/local/hadoop  
Запускаю компоненты по отдельности:  
1. Отформатировала NameNode

/usr/local/hadoop/bin/hdfs namenode -format

2. Запустила HDFS компоненты отдельно

/usr/local/hadoop/sbin/hadoop-daemon.sh start namenode
/usr/local/hadoop/sbin/hadoop-daemon.sh start datanode
/usr/local/hadoop/sbin/hadoop-daemon.sh start secondarynamenode

3. Запустила YARN компоненты

/usr/local/hadoop/sbin/yarn-daemon.sh start resourcemanager
/usr/local/hadoop/sbin/yarn-daemon.sh start nodemanager

4. Проверила, что все запустилось

jps

<img width="1473" height="587" alt="2" src="https://github.com/user-attachments/assets/d9e5f77e-3276-400e-903a-d8d90cedc621" />

В новом окне терминала буду работать с HDFS, который работает внутри Docker-контейнера (первое окно не закрываю, иначе не будет работать).  
Устанавливаю Hive, чтобы выполнять SQL-запросы.   
1. Подключаюсь к контейнеру с правами root:  

docker exec -it --user root hadoop-cluster bash  

2. Обновляю список пакетов и установливаю wget  

apt-get update && apt-get install -y wget

<img width="1167" height="536" alt="3" src="https://github.com/user-attachments/assets/1bf2a099-81da-43a3-8a5f-ce0d3683f4ac" />

3. Скачиваю Hive  

wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz  

<img width="1439" height="307" alt="4" src="https://github.com/user-attachments/assets/1ed1e148-7f36-47ff-b12d-5e9b71088a82" />

4. Распаковываю архив  

tar -xzvf apache-hive-3.1.3-bin.tar.gz

<img width="1090" height="607" alt="5" src="https://github.com/user-attachments/assets/329e472a-5a5c-4b24-af88-29f1ddae5ff0" />

5. Перемещаю Hive в удобную папку  

mv apache-hive-3.1.3-bin /opt/hive

Настраиваю переменные окружения  
1. Добавляю Hive в PATH  

echo 'export HIVE_HOME=/opt/hive' >> ~/.bashrc  
echo 'export PATH=$PATH:$HIVE_HOME/bin' >> ~/.bashrc

2. Применяю изменения  

source ~/.bashrc

3. Проверяю

echo $HIVE_HOME

<img width="920" height="147" alt="6" src="https://github.com/user-attachments/assets/fa168526-f0c3-4294-a00c-f1ae3af606e4" />

Создаю папки для Hive в HDFS

hdfs dfs -mkdir -p /tmp  
hdfs dfs -mkdir -p /user/hive/warehouse  
hdfs dfs -chmod g+w /tmp  
hdfs dfs -chmod g+w /user/hive/warehouse  

Проверяю, что создалось

hdfs dfs -ls /user/hive/

<img width="977" height="191" alt="7" src="https://github.com/user-attachments/assets/f7c5a27b-0487-47be-8e32-663fe17447c8" />

Инициализирую Metastore  
1. Перехожу в папку Hive  

cd /opt/hive

2. Инициализирую схему Metastore (используя Derby)

bin/schematool -dbType derby -initSchema

<img width="1460" height="310" alt="8" src="https://github.com/user-attachments/assets/77b1e711-641a-4430-8439-5bbd77bb5797" />
<img width="502" height="117" alt="9" src="https://github.com/user-attachments/assets/a0992c55-5449-4568-8ed4-4de50cff32bc" />

3. Запустила Hive  
<img width="1469" height="354" alt="10" src="https://github.com/user-attachments/assets/9f99baca-7785-4357-9a95-62a6e034a8e3" />

Создала файл с sql кодом bd.sql, в котором код создания и заполнения таблиц разных моделей: звезда, снежинка, Data Vault. Его содержимое есть в репозитории.  
В новом окне копирую файл в контейнер командой и закрываю окно   

docker cp D:/bd.sql hadoop-cluster:/bd.sql

В окне с контейнером загружаю файл  

hive -f /bd.sql
<img width="1464" height="415" alt="11" src="https://github.com/user-attachments/assets/83d780be-d081-4363-ba77-0c0782e9e768" />

Проверяю, что все загрузилось

SHOW DATABASES;  
USE carsharing;  
SHOW TABLES;  

<img width="879" height="743" alt="12" src="https://github.com/user-attachments/assets/77b479d0-79e5-4ea9-8ae3-1d2b3f0b007a" />
<img width="842" height="212" alt="13" src="https://github.com/user-attachments/assets/e53d8ac0-b892-4531-93f7-0e5c4d4749be" />

Вижу, что все таблицы отображаются, записи таблиц выводятся
