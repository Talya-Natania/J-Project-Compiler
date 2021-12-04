NB. connect to the function of read line by line
load 'c:\users\user\j902-user\temp\readfile.ijs'
 NB.  Load regex library
load'regex'              
NB.--------------is keyword--------------------------------------------------------------------------------------
isKeyWord=:monad define
i=.0
len=.#keywords
while.(i<len) do.
a=.i{ keywords
if. y-:>a  do.
1 return.
end.
i=.i+1
end.
)
NB.--------------help function-----------------------------------------------------------------------------------------
isSuit=:monad define
current=:":y
val=.'[0-9]*' rxeq current
val2=.'[a-z]*[A-Z]*' rxeq current
if. y~:' ' do.
if. (y-:'_')+.(val>0 )+.(val2>0) do. 1 return. end.
end.
)
NB.--------------q4--------------------------------------------------------------------------------------
q4=:monad define
smoutput 'q4'
if.(y-:'<') do.
('<symbol>',' &lt; ', '</symbol>',CRLF)fappend outputfile
return.
end.
if.(y-:'>') do.
('<symbol>',' &gt; ', '</symbol>',CRLF)fappend outputfile
return.
end.
if.(y-:'&') do.
('<symbol>',' &amp; ', '</symbol>',CRLF)fappend outputfile
return.
end.
('<symbol>',' ',y,' ', '</symbol>',CRLF)fappend outputfile
return.
)

NB.--------------q0--------------------------------------------------------------------------------------

q0=:dyad define
i=.x
smoutput 'q0'
while. (i<#y) do.
choise=.":i{y
NB.smoutput <i{y
fallow=.i+1
if. choise -:'/' do. 
k=.i+1
l=.":k{y
if.(l-:'/') do.
 return.
 end.
if.(l-:'*') do.
 return.
end.
end.
if. choise -:']' do. q4 choise end.
check=.'[0-9]*' rxeq choise
if. check>0 do.
i=.i q3 y
i=.i-1
 end.
check=.'[,{,},;,(,),[,&,|,.,+,*,/,<,>,=,~,-]' rxeq choise
if. check>0 do.
q4 choise
 end.
if. choise-:'"' do.
i=.fallow q5 y
i=.i-1 
end.
check=.'[a-z]*[A-Z]*' rxeq choise
if. check>0  do.
i=.fallow q12 y
i=.i-1
end.
i=.i+1
end.

)
NB.--------------readlines-------------------------------------------------------------------------------

letters=:monad define
smoutput 'next line'
exemple=.y conew 'linereader'
y=.next__exemple''
while. (#y)>0 do.
0 q0 y
y=.next__exemple''
end.

)
NB.-----------------------------Q12-------------------------------------------------------------------------
q12=:dyad define
str=:''
i=.x
i=.i-1
ans=.isSuit i{y
while. ans-:1 do.
str=:str,i{y
i=.i+1
ans=.isSuit i{y
end.
ans=.isKeyWord str
val=.'[a-z]*[A-Z]*' rxeq ":i{y
if.( val<1) *.(ans-:1)  do.
('<keyword>',str, '</keyword>',CRLF)fappend outputfile
i return.
else.
('<identifier>',str, '</identifier>',CRLF)fappend outputfile
i return.
end.
) 
NB.--------------q3-----------------------------------------------------------------------------------------

q3=:dyad define
smoutput 'q3'
i=.x
current=:":i{y
word=:''
check=.'[0-9]*' rxeq current
while. check>0 do.
word=:word,current
i=.i+1
current=:":i{y
check=.'[0-9]*' rxeq current
end.
('<integerConstant>',word, '</integerConstant>',CRLF)fappend outputfile
i return.
)


NB.--------------q5-----------------------------------------------------------------------------------------

q5=:dyad define
smoutput 'q5'
i=.x
current=:":i{y
word=:''
while. current ~: '"' do.
word=:word,current
i=.i+1
current=:":i{y
end.
('<stringConstant>',word, '</stringConstant>',CRLF)fappend outputfile
i=.i+1
i return.
)




NB.--------------Main---------------------------------------------------------------------------------------

keywords=: 'class';'constructor';'function';'method';'field';'static';'var';'int';'char';'boolean';'void';'true';'false';'null';'this';'let';'do';'if';'else';'while';'return'
NB. put here the path of the field
path=:'C:\Users\USER\Desktop\Exercises\Targil5\project 11\Pong'
file=:'C:\Users\USER\Desktop\Exercises\Targil5\project 11\Pong\PongGame.jack'
y =.('\') chopstring file
dirName=. >_1 { y
smoutput dirName
y =.('.') chopstring dirName
dirName=. >0 { y
outputfile=: path ,'\',dirName,'T.xml'
('<tokens>',CRLF)fappend outputfile
letters file
('</tokens>',CRLF)fappend outputfile




