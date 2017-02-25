FROM mysql:5.7

RUN { \
      echo '[mysqld]'; \
      echo 'skip-character-set-client-handshake'; \
      echo 'character-set-server=utf8mb4'; \
      echo 'collation-server=utf8mb4_general_ci'; \
      echo '[client]'; \
      echo 'default-character-set=utf8mb4'; \
    } > /etc/mysql/conf.d/charset.cnf
