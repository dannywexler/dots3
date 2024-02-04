[ -t 0 ] && FNAME=$1 || FNAME=$(cat)
# echo "got filename $FNAME"
HASH_KEY="user.xxh"
hash=$(getfattr -n $HASH_KEY --only-values "$FNAME" 2> /dev/null)
if [ $? -ne 0 ]
then
    # echo "hash in xattr: $hash"
# else
    # echo "no hash in xattr"
    hash=$(xxhsum -H3 "$FNAME" | choose -1) 
    # echo "calculated hash $hash"
    setfattr -n $HASH_KEY -v $hash "$FNAME"
    # echo "saved to xattr"
fi

echo $hash
