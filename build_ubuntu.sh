VERSION=2.7.2

gpg --import private_key.asc

mkdir -p /vagrant/build
cd /vagrant/build

wget https://github.com/mongodb/mongo-python-driver/archive/$VERSION.tar.gz

tar xfz $VERSION.tar.gz
rm -f $VERSION.tar.gz
mv mongo-python-driver-$VERSION pymongo-$VERSION
tar cfz pymongo_$VERSION.orig.tar.gz pymongo-$VERSION

cp -r ../debian ./pymongo-$VERSION
cd pymongo-$VERSION

sed -i -e 's/0ubuntu1) unstable;/0ubuntu1~trusty) trusty;/g' debian/changelog
debuild -S
sed -i -e 's/0ubuntu1~trusty) trusty;/0ubuntu1~precise) precise;/g' debian/changelog
debuild -S

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/ppa ./build/pymongo_'$VERSION'-0ubuntu1~trusty_source.changes'
echo 'sudo dput ppa:pritunl/ppa ./build/pymongo_'$VERSION'-0ubuntu1~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-dev ./build/pymongo_'$VERSION'-0ubuntu1~trusty_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-dev ./build/pymongo_'$VERSION'-0ubuntu1~precise_source.changes'
