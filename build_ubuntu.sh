VERSION=2.7.2

gpg --import private_key.asc

mkdir -p /vagrant/build
cd /vagrant/build

wget http://archive.ubuntu.com/ubuntu/pool/main/p/pymongo/pymongo_$VERSION.orig.tar.gz
tar xfz pymongo_$VERSION.orig.tar.gz

cp -r ../debian ./pymongo-$VERSION
cd pymongo-$VERSION

sed -i -e 's/ubuntu1) unstable;/ubuntu1~trusty) trusty;/g' debian/changelog
debuild -S
sed -i -e 's/ubuntu1~trusty) trusty;/ubuntu1~precise) precise;/g' debian/changelog
debuild -S

cd ..

echo '\n\nRUN COMMANDS BELOW TO UPLOAD:'
echo 'sudo dput ppa:pritunl/ppa ./build/pymongo_'$VERSION'-0ubuntu1~trusty_source.changes'
echo 'sudo dput ppa:pritunl/ppa ./build/pymongo_'$VERSION'-0ubuntu1~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-dev ./build/pymongo_'$VERSION'-0ubuntu1~trusty_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-dev ./build/pymongo_'$VERSION'-0ubuntu1~precise_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/pymongo_'$VERSION'-0ubuntu1~trusty_source.changes'
echo 'sudo dput ppa:pritunl/pritunl-test ./build/pymongo_'$VERSION'-0ubuntu1~precise_source.changes'
