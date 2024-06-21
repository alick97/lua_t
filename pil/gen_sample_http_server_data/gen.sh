function gen() {
    local file_name=$1
    local count=$2
    tr -dc A-Za-z0-9 < /dev/urandom | head -c $count > $file_name
}


gen $@
