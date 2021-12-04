load 'c:\users\user\j902-user\temp\readfile.ijs'NB. connect to the function of read line by line
load'regex'
NB.--------------expressionList-------------------------------------------------------------------------------
expressionList=:monad define
('<expressionList>',CRLF)fappend outputfile
check=.checkNextToken y
while.-.(check-:' ) ') do.
 expression y
check1=.checkNextToken y
while.(check1-:' , ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
check1=.checkNextToken y
end.
check=.checkNextToken y
end.
('</expressionList>',CRLF)fappend outputfile
return.
)
NB.--------------subroutineCall-------------------------------------------------------------------------------
subroutineCall=:monad define
smoutput 'subroutineCall'
check=.checkNextToken y
smoutput check
if.(check-:' ( ') do.
smoutput 'if'
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expressionList y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
else.
smoutput 'else'
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
expressionList y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
end.
return.
)
NB.--------------term-------------------------------------------------------------------------------
term=:monad define
('<term>',CRLF)fappend outputfile
check1=.outNextToken y
if.(check1-:'/stringConstant')+.(check1-:'/integerConstant') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
elseif.( check1-:' true ')+.(check1-:' false ')+.(check1-:' null ')+.(check1-:' this ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
elseif.(check1-:'/identifier') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check=.checkNextToken y
if.(check-:' [ ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken y
(next,CRLF)fappend outputfile
elseif.(check-:' ( ')+.(check-:' . ') do.
subroutineCall y
end.
elseif.(check1-:' ( ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
elseif.(check1-:' - ')+.(check1-:' ~ ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
term y
end.
('</term>',CRLF)fappend outputfile
return.
)
NB.--------------expression-------------------------------------------------------------------------------
expression=:monad define
('<expression>',CRLF)fappend outputfile
term y
check1=. checkNextToken y
while.(check1-:' - ')+.(check1-:' + ')+.(check1-:' * ')+.(check1-:' / ')+.(check1-:' &amp; ')+.(check1-:' | ')+.(check1-:' &lt; ')+.(check1-:' &gt; ')+.(check1-:' = ') do.
next=.getNextToken y
(next,CRLF)fappend outputfile
term y
NB.check=. checkNextToken y
check1=.checkNextToken y
end.
('</expression>',CRLF)fappend outputfile
return.
)
NB.--------------returnStatement-------------------------------------------------------------------------------
returnStatement=:monad define
('<returnStatement>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check=. checkNextToken y
if. -.(check-:' ; ') do.
 expression y
end.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</returnStatement>',CRLF)fappend outputfile
return.
)
NB.--------------doStatement-------------------------------------------------------------------------------
doStatement=:monad define
('<doStatement>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 subroutineCall y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</doStatement>',CRLF)fappend outputfile
return.
)
NB.--------------whileStatement-------------------------------------------------------------------------------
whileStatement=:monad define
('<whileStatement>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 statements y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</whileStatement>',CRLF)fappend outputfile
return.
)
NB.--------------ifStatement-------------------------------------------------------------------------------
ifStatement=:monad define
('<ifStatement>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 statements y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check=. checkNextToken y
if. (check-:' else ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 statements y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
end.
('</ifStatement>',CRLF)fappend outputfile
return.
)
NB.--------------letStatement-------------------------------------------------------------------------------
letStatement=:monad define
('<letStatement>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check=. checkNextToken y
if. (check-:' [ ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
end.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
 expression y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</letStatement>',CRLF)fappend outputfile
return.
)
NB.--------------statements-------------------------------------------------------------------------------
statements=:monad define
('<statements>',CRLF)fappend outputfile
check=.checkNextToken y
while. (check-:' let ')+.(check-:' if ')+.(check-:' while ')+.(check-:' do ')+.(check-:' } ') do.
select. check
case. ' let ' do.
letStatement y
case. ' if ' do.
ifStatement y
case. ' while ' do.
whileStatement y
case. ' do ' do.
doStatement y
case. ' } ' do.
('</statements>',CRLF)fappend outputfile
return.
end.
check=.checkNextToken y
end.
if. (check-:' return ') do.
returnStatement y
end.
('</statements>',CRLF)fappend outputfile
return.
)
NB.--------------subrutineBody-------------------------------------------------------------------------------
subrutineBody=:monad define
('<subroutineBody>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check=.checkNextToken y
while. (check-:' var ') do.
('<varDec>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check2=.checkNextToken y
while.(check2-:' , ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check2=.checkNextToken y
end.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</varDec>',CRLF)fappend outputfile
check=.checkNextToken y
end.
 statements y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</subroutineBody>',CRLF)fappend outputfile
return.
)
NB.--------------parameterList-------------------------------------------------------------------------------
parameterList=:monad define
('<parameterList>',CRLF)fappend outputfile
check=.checkNextToken y
while.-.(check-:' ) ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check1=.checkNextToken y
while.(check1-:' , ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check1=.checkNextToken y
end.
check=.checkNextToken y
end.
('</parameterList>',CRLF)fappend outputfile
return.
)
NB.--------------parseClassSubDec-------------------------------------------------------------------------------
parseClassSubDec=:monad define
smoutput 'subroutineDec'
check=.checkNextToken y
smoutput check
while. (check-:' constructor ')+.(check-:' function ')+.(check-:' method ') do.
('<subroutineDec>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
parameterList y
next=.getNextToken tokens
(next,CRLF)fappend outputfile
subrutineBody y
('</subroutineDec>',CRLF)fappend outputfile
check=.checkNextToken y
smoutput check
end.
return.
)
NB.--------------parseClassVarDec-------------------------------------------------------------------------------
parseClassVarDec=:monad define
check=.checkNextToken tokens
while. (check-:' static ')+.(check-:' field ') do.
('<classVarDec>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check1=.checkNextToken tokens
while.(check1-:' , ') do.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
check1=.checkNextToken tokens
end.
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</classVarDec>',CRLF)fappend outputfile
check=.checkNextToken tokens
end.
return.
)
NB.--------------parseclass-------------------------------------------------------------------------------
parseclass=:monad define 
smoutput 'parseclass'
('<class>',CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
next=.getNextToken tokens
(next,CRLF)fappend outputfile
parseClassVarDec tokens
parseClassSubDec tokens
next=.getNextToken tokens
(next,CRLF)fappend outputfile
('</class>',CRLF)fappend outputfile
)
NB.--------------outNextToken-------------------------------------------------------------------------------
outNextToken=:monad define
nextTok=. ":>i{ tokens
help=.('>') chopstring nextTok
nextTok=.>1{help
help=.('<') chopstring nextTok
check=.":>1{help
check return.
)
NB.--------------checkNextToken-------------------------------------------------------------------------------
checkNextToken=:monad define
nextTok=. ":>i{ tokens
help=.('>') chopstring nextTok
nextTok=.>1{help
help=.('<') chopstring nextTok
check=.":>0{help
check return.
)
NB.--------------getNextToken-------------------------------------------------------------------------------
getNextToken=:monad define
nextTok=. ":>i{ y
i=:i+1
nextTok return.
)
NB.--------------getallTokens-------------------------------------------------------------------------------
allTokens=:monad define
exemple=.y conew 'linereader'
y=.next__exemple''
tokens=:<y
y=.next__exemple''
while. (#y)>0 do.
more=.<y
tokens=:tokens,more
y=.next__exemple''
end.
)
NB.--------------Main---------------------------------------------------------------------------------------
NB. put here the path of the field
i=:1
path=:'C:\Users\USER\Desktop\Exercises\Targil4\project 10\ArrayTest'
file=:'C:\Users\USER\Desktop\Exercises\Targil4\project 10\ArrayTest\MainT-copy.xml'
y =.('\') chopstring file
dirName=. >_1 { y
y =.('.') chopstring dirName
dirName=. >0 { y
y =.('T') chopstring dirName
dirName=. >0 { y
outputfile=: path ,'\',dirName,'.xml'
allTokens file
parseclass tokens