CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f ListExamples.java ]]
then
    echo "File Found"
else
    echo "File Not Found"
    exit 1
fi

cp ListExamples.java ..

cd ..

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> compile-error.txt

if [[ $? -ne 0 ]]
then
    echo "Compile Error - Grade: Fail"
    exit 2
else
    echo "Compile Success"
fi

java -cp ".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > runtime-error.txt

if [[ $? -ne 0 ]]
then
    cat runtime-error.txt
    echo "Runtime Error - Grade: Fail"
else
    echo "Runtime Success"
    echo "Grade: Pass"
fi
cp student-submission/ListExamples.java ./
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

