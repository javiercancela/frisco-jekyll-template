JEKYLL_ENV=production bundle exec jekyll build 
git add -A .
git commit -m "Changes"
git push origin release
rm -rf ../site

