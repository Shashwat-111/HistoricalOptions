# OptionsView
A website for viewing historical options data of the Indian market in candlestick format


flutter clean 
flutter pub get 
flutter build web --base-href /HistoricalOptions.in/ --release
cd build/web
git init 
git add . 
git commit -m "Deploy 2"
git remote add origin https://github.com/Shashwat-111/HistoricalOptions.in.git
git branch -M main
git push -u --force origin main 