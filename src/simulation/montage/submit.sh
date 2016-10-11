echo "Removing data from a previous execution"
rm -rf exp/Calculate*
rm -rf exp/Create*
rm -rf exp/Extract*
rm -rf exp/Fit*
rm -rf exp/List*
rm -rf exp/Projection*
rm -rf exp/Select*
echo "Executing A-Chiron Setup..."
bin/A-Chiron-Setup-v1.0 -d a-chiron.xml
bin/A-Chiron-Setup-v1.0 -i a-chiron.xml
echo "Executing A-Chiron Core..."
bin/A-Chiron-Core-v1.0 a-chiron.xml