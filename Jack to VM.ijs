load 'c:\users\user\j902-user\temp\readfile.ijs'NB. connect to the function of read line by line
load'regex'
NB.--------------expressionList-------------------------------------------------------------------------------
expressionList=:monad define
check=.checkNextToken y
while.-.(check-:' ) ') do.
numOfParameters=:numOfParameters+1
 expression y
check1=.checkNextToken y
while.(check1-:' , ') do.
getNextToken tokens NB.,
numOfParameters=:numOfParameters+1
 expression y
check1=.checkNextToken y
end.
check=.checkNextToken y
end.
return.
)
NB.--------------subroutineCall-------------------------------------------------------------------------------
subroutineCall=:monad define
numOfParameters=:0
name=.getNextToken y NB.<identifier>className or varName or subroutineName </identifier>
check=. checkNextToken y
NB.subroutineName ( expressionList )
smoutput check
smoutput name
NB. my class method
if. (check-:' ( ') do.
numOfParameters=:numOfParameters+1
getNextToken y NB. (
('push pointer 0',CRLF)fappend outputfile
expressionList y
n=.":numOfParameters
('call ',ClassName,'.',name,' ', n,CRLF)fappend outputfile
getNextToken y
check=. checkNextToken y
NB.next token is '.' the subroutineCall is a method
elseif. (check-:' . ') do.
getNextToken y NB. .
subroutineName=.getNextToken y
getNextToken y NB. (
check2=.findIndex name
smoutput check2
NB. if the subroutine called by object: (method)
if. (check2!=_1) do.
numOfParameters=:numOfParameters+1
kindOfVar=. findKind name
smoutput kindOfVar
if. (kindOfVar -:'field') +. (kindOfVar-:'static') do.kindOfVar=.'this' end.
indexOfKind =. ":findIndex name
typeOfKind =.findType name
('push ',kindOfVar,' ',indexOfKind,CRLF)fappend outputfile
expressionList y
n=.":numOfParameters
('call ',typeOfKind,'.',subroutineName,' ',n,CRLF)fappend outputfile
NB.else: called by class (function)
else.
expressionList y
n=.":numOfParameters
('call ',name,'.',subroutineName,' ',n,CRLF)fappend outputfile
end.
getNextToken y 
end.
)
NB.--------------term-------------------------------------------------------------------------------
term=:monad define
smoutput 'term'
check1=.outNextToken y
check2=.checkNextToken y
smoutput check1
smoutput check2
if.(check1-:'/stringConstant') do.
next=.getNextToken tokens
size=. #next
smoutput size
s=. ":size
('push constant ',s,CRLF,'call String.new 1',CRLF)fappend outputfile
ascii=. a. i. next
smoutput ascii
for_x. i. size do.
smoutput 'for'
c=. ": x{ascii
('push constant ',c,CRLF,'call String.appendChar 2',CRLF)fappend outputfile
end.
elseif.(check1-:'/integerConstant') do.
next=.getNextToken tokens
('push constant ',next,CRLF)fappend outputfile
elseif.(check1-:'/keyword') do.
check=.checkNextToken y
if.( check-:'true') do.
('push constant 0',CRLF,'not',CRLF)fappend outputfile
getNextToken y
elseif.(check-:'false') do.
('push constant 0',CRLF)fappend outputfile
getNextToken y
elseif.(check-:'null')do.
('push constant 0',CRLF)fappend outputfile
getNextToken y
elseif.(check-:'this') do.
('push pointer 0',CRLF)fappend outputfile
getNextToken y
end.
elseif.(check1-:'/identifier') do.
varName=.getNextToken tokens
check=.checkNextToken y
if.(check-:' [ ') do.
varKind=.findKind varName
if.(varKind-:'field') do. varKind=.'this' end.
varIndex=.": findIndex varName
getNextToken y NB. [
 expression y
getNextToken y NB. ]
('push ',varKind,' ' ,varIndex,CRLF,'add',CRLF,'pop pointer 1',CRLF,'push that 0',CRLF)fappend outputfile
elseif.(check-:' ( ')+.(check-:' . ') do.
i=:i-1
subroutineCall y
else.
varKind=.findKind varName
if.(varKind-:'field') do. varKind=.'this' end.
varIndex=. findIndex varName
v=.":varIndex
('push ',varKind,' ' ,v,CRLF)fappend outputfile
end.
elseif.(check2-:' ( ') do.
getNextToken tokens NB. (
 expression y
getNextToken tokens NB. )

elseif.(check2-:' - ')do.
getNextToken tokens NB. -
term y
('neg',CRLF)fappend outputfile
elseif.(check2-:' ~ ') do.
getNextToken tokens NB. ~
term y
('not',CRLF)fappend outputfile
end.
return.
)
NB.--------------expression-------------------------------------------------------------------------------
expression=:monad define
term y
check1=. checkNextToken y
while.(check1-:' - ')+.(check1-:' + ')+.(check1-:' * ')+.(check1-:' / ')+.(check1-:' &amp; ')+.(check1-:' | ')+.(check1-:' &lt; ')+.(check1-:' &gt; ')+.(check1-:' = ') do.
tok=.getNextToken y
term y
select. tok
case. ' + ' do.
('add',CRLF)fappend outputfile
case. ' - ' do.
('sub',CRLF)fappend outputfile
case. ' * ' do.
('call Math.multiply 2',CRLF)fappend outputfile
case. ' / ' do.
('call Math.divide 2',CRLF)fappend outputfile
case. ' &amp; ' do.
('and',CRLF)fappend outputfile
case. ' | ' do.
('or',CRLF)fappend outputfile
case. ' &lt; ' do.
('lt',CRLF)fappend outputfile
case. ' &gt; ' do.
('gt',CRLF)fappend outputfile
case. ' = ' do.
('eq',CRLF)fappend outputfile
end.
check1=.checkNextToken y
end.
return.
)
NB.--------------returnStatement-------------------------------------------------------------------------------
returnStatement=:monad define
getNextToken tokens NB. return
check=. checkNextToken y
if. -.(check-:' ; ') do.
 expression y
else.
('push constant 0',CRLF)fappend outputfile
end.
('return',CRLF)fappend outputfile
getNextToken tokens NB. ;
return.
)
NB.--------------doStatement-------------------------------------------------------------------------------
doStatement=:monad define
getNextToken tokens NB. do
subroutineCall y
('pop temp 0',CRLF)fappend outputfile
getNextToken tokens NB. ;
return.
)
NB.--------------whileStatement-------------------------------------------------------------------------------
whileStatement=:monad define
getNextToken tokens NB. while
getNextToken tokens NB. (
index=.indexWhileLabel
in=.":index
('label WHILE_EXP',in,CRLF)fappend outputfile
indexWhileLabel=:indexWhileLabel+1
 expression y
in=.":index
('not',CRLF,'if-goto WHILE_END',in,CRLF)fappend outputfile
getNextToken tokens NB. )
getNextToken tokens NB. {
 statements y
in=.":index
('goto WHILE_EXP',in,CRLF,'label WHILE_END',in,CRLF)fappend outputfile
getNextToken tokens NB. }
return.
)
NB.--------------ifStatement-------------------------------------------------------------------------------
ifStatement=:monad define
getNextToken tokens NB. if
getNextToken tokens NB. (
 expression y
getNextToken tokens NB. )
index=.":indexIfLabel
('if-goto IF_TRUE',index,CRLF,'goto IF_FALSE',index,CRLF,'label IF_TRUE',index,CRLF)fappend outputfile
getNextToken tokens NB. {
indexIfLabel=:indexIfLabel+1
 statements y
getNextToken tokens NB. }
check=. checkNextToken y
if. (check-:'else') do.
getNextToken tokens NB. else
getNextToken tokens NB. {
('goto IF_END',index,CRLF,'label IF_FALSE',index,CRLF)fappend outputfile
 statements y
getNextToken tokens NB. }
('label IF_END',index,CRLF)fappend outputfile
else.
('label IF_FALSE',index,CRLF)fappend outputfile
end.
return.
)
NB.--------------letStatement-------------------------------------------------------------------------------
letStatement=:monad define
getNextToken tokens NB. let
varName=.getNextToken tokens
varKind=.findKind varName
if.(varKind-:'field') do.
varKind=.'this'
end.
varIndex=.":findIndex varName
check=. checkNextToken y
if. (check-:' [ ') do.
getNextToken tokens NB. [
 expression y
getNextToken tokens NB. ]
('push ',varKind,' ',varIndex,CRLF,'add',CRLF)fappend outputfile
getNextToken tokens NB. =
 expression y
('pop temp 0',CRLF,'pop pointer 1',CRLF,'push temp 0',CRLF,'pop that 0',CRLF)fappend outputfile
getNextToken tokens NB. ;
else.
getNextToken tokens NB. = 
 expression y
('pop ',varKind,' ',varIndex,CRLF)fappend outputfile
getNextToken tokens NB. ;
end.
return.
)
NB.--------------statements-------------------------------------------------------------------------------
statements=:monad define
check=.checkNextToken y
smoutput 'statments'
while. (check-:'let')+.(check-:'if')+.(check-:'while')+.(check-:'do') do.
select. check
case. 'let' do.
letStatement y
case. 'if' do.
ifStatement y
case. 'while' do.
whileStatement y
case. 'do' do.
doStatement y
end.
smoutput '!!!!!!'
check=.checkNextToken y
smoutput check
end.
if. (check-:'return') do.
returnStatement y
end.
return.
)
NB.--------------parsVarDec-------------------------------------------------------------------------------
parsVarDec=:monad define
Kind=.'local'
check=.checkNextToken y
while. (check-:'var') do.
getNextToken tokens NB. var
Type=.getNextToken tokens
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check2=.checkNextToken y
while.(check2-:' , ') do.
getNextToken tokens NB. ,
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check2=.checkNextToken y
end.
getNextToken tokens NB. ;
check=.checkNextToken y
end.
c=.":local
('function ',ClassName,'.',FuncName,' ',c,CRLF)fappend outputfile

)
NB.--------------subrutineBody-------------------------------------------------------------------------------
subrutineBody=:monad define
getNextToken tokens NB. {
parsVarDec y
if. (CurrentFuncType-:'constructor') do.
smoutput NameClassTable
sum=.static+field
s=.":sum
NB. malloc memory to the class and pop the pointer to first field  
('push constant ',s,CRLF,'call Memory.alloc 1',CRLF,'pop pointer 0',CRLF)fappend outputfile
end.
if. (CurrentFuncType-:'method') do.
NB. in pointer 0 we put the  object class 
('push argument 0',CRLF,'pop pointer 0',CRLF)fappend outputfile
end.
 statements y
getNextToken tokens NB. }
return.
)
NB.--------------parameterList-------------------------------------------------------------------------------
parameterList=:monad define
Kind=.'argument'
check=.checkNextToken y
while.-.(check-:' ) ') do.
Type=.getNextToken tokens
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check1=.checkNextToken y
while.(check1-:' , ') do.
getNextToken tokens NB. ,
Type=.getNextToken tokens
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check1=.checkNextToken y
end.
check=.checkNextToken y
end.
return.
)
NB.--------------parseClassSubDec-------------------------------------------------------------------------------
parseClassSubDec=:monad define
smoutput 'subroutineDec'
check=.checkNextToken y
while. (check-:'constructor')+.(check-:'function')+.(check-:'method') do.
KindFuncTable=:<' '
TypeFuncTable=:<' '
NameFuncTable=:<' '
NumberFuncTable=:<' '
indexIfLabel=:0  
indexWhileLabel=:0
argument=:0
local=:0
CurrentFuncType=:getNextToken tokens
ReturnType=.getNextToken tokens
FuncName=:getNextToken tokens
if. (check-:'method') do.
send=.'this';ClassName;'argument'
add send
end.
getNextToken tokens NB. (
parameterList y
getNextToken tokens NB. )
subrutineBody y
check=.checkNextToken y
end.
return.
)
NB.--------------parseClassVarDec-------------------------------------------------------------------------------
parseClassVarDec=:monad define
check=.checkNextToken tokens
while. (check-:'static')+.(check-:'field') do.
Kind=.getNextToken tokens
Type=.getNextToken tokens
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check1=.checkNextToken tokens
while.(check1-:' , ') do.
getNextToken tokens NB. ,
Name=.getNextToken tokens
send=.Name;Type;Kind
add send
check1=.checkNextToken tokens
end.
getNextToken tokens NB. ;
check=.checkNextToken tokens
end.
return.
)
NB.--------------parseclass-------------------------------------------------------------------------------
parseclass=:monad define 
smoutput 'parseclass'
KindClassTable=:<' '
TypeClassTable=:<' '
NameClassTable=:<' '
NumberClassTable=:<' '
static=:0
field=:0
getNextToken tokens NB. class
ClassName=:getNextToken tokens NB. identifier-class name
getNextToken tokens NB. symbol-{
parseClassVarDec tokens
parseClassSubDec tokens
getNextToken tokens NB. symbol-}
)
NB.--------------finds the index in the symble table -------------------------------------------------------------------------------
findIndex=:monad define
n=.argument+local+1
for_x.i. n do.
if. (y-:>x{ NameFuncTable) do. 
>x{NumberFuncTable return.
end.
end.
n=.static+field+1
for_x.i. n do.
if. (y-:>x{ NameClassTable) do. 
>x{NumberClassTable return.
end.
end.
-1 return.
)
NB.--------------finds the type in the symble table -------------------------------------------------------------------------------
findType=:monad define
n=.argument+local+1
for_x.i. n do.
if. (y-:>x{ NameFuncTable) do. 
>x{TypeFuncTable return.
end.
end.
n=.static+field+1
for_x.i. n do.
if. (y-:>x{ NameClassTable) do. 
>x{TypeClassTable return.
end.
end.
)
NB.--------------finds the kind in the symble table -------------------------------------------------------------------------------
findKind=:monad define
n=.argument+local+1
for_x.i. n do.
if. (y-:>x{ NameFuncTable) do. 
>x{KindFuncTable return.
end.
end.
n=.static+field+1
for_x.i. n do.
if. (y-:>x{ NameClassTable) do. 
>x{KindClassTable return.
end.
end.
)
NB.--------------adds row to the symble table-------------------------------------------------------------------------------
NB.gets name,type,kind
add=:monad define
choise=.>2{y
select. choise
case. 'static' do.
KindClassTable=:KindClassTable,2{y
TypeClassTable=:TypeClassTable,1{y
NameClassTable=:NameClassTable,0{y
NumberClassTable=:NumberClassTable,<static
static=:static+1
case. 'field' do.
KindClassTable=:KindClassTable,2{y
TypeClassTable=:TypeClassTable,1{y
NameClassTable=:NameClassTable,0{y
NumberClassTable=:NumberClassTable,<field
field=:field+1
case. 'argument' do.
KindFuncTable=:KindFuncTable,2{y
TypeFuncTable=:TypeFuncTable,1{y
NameFuncTable=:NameFuncTable,0{y
NumberFuncTable=:NumberFuncTable,<argument
argument=:argument+1
case. 'local' do.
KindFuncTable=:KindFuncTable,2{y
TypeFuncTable=:TypeFuncTable,1{y
NameFuncTable=:NameFuncTable,0{y
NumberFuncTable=:NumberFuncTable,<local
local=:local+1
end.
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
nextTok=. ":>i{ tokens
help=.('>') chopstring nextTok
nextTok=.>1{help
help=.('<') chopstring nextTok
check=.":>0{help
i=:i+1
check return.
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
path=:'C:\Users\USER\Desktop\Exercises\Targil5\project 11\ConvertToBin'
file=:'C:\Users\USER\Desktop\Exercises\Targil5\project 11\ConvertToBin\MainT.xml'
y =.('\') chopstring file
dirName=. >_1 { y
y =.('.') chopstring dirName
dirName=. >0 { y
y =.('T') chopstring dirName
dirName=. >0 { y
outputfile=: path ,'\',dirName,'.vm'
ClassName=: ' '
FuncName=: ' '
allTokens file
smoutput tokens
parseclass tokens