for cb in `knife cookbook list`; do
  knife cookbook show $cb $2 --format=json > environments/$cb.json
done
