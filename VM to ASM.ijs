load 'c:\users\user\j902-user\temp\readfile.ijs'NB. connect to the function of read line by line
NB. Serves:
NB. Talya Yazdi-Natanya & Naama Arivi
NB. 211976295  314660168
NB.Group: 150060.3.5781.01

NB. connect to the function of read line by line
NB. to the function of read line by line

NB. A func that chack the suffix of the files

suffix =:monad define
for_file. y do.
helper=. >file
n=. ('.') chopstring helper
temp=. >  _1 { n
if. temp-:'vm'  do.
name=.('/') chopstring helper
counter2=:0
a=. >_1{name
b=.('.') chopstring a
filename=: >0 { b
 func2 helper NB. sends the file to a function that reads from the file
 end.
 end.
)

NB. Func that check the first word of each line and act accordingly
func2=:monad define
exemple=.y conew 'linereader'
y=.next__exemple''
while. (#y)>0 do.
T=.(' ') chopstring y
choise=. >0 { T
select. choise 
case. '//' do.
case. 'label' do.
('//',y,CRLF) fappend outputfile
c=. >1{T
c2=.('.') chopstring c
c3=.>_1{ c2
('(',filename,'.', c3,')',CRLF) fappend outputfile
case. 'goto' do.
('//',y,CRLF) fappend outputfile
c=. >1{T
c2=.('.') chopstring c
c3=.>_1{ c2
('@',filename,'.', c3,CRLF,'0;JMP',CRLF) fappend outputfile
case.'if-goto' do.
('//',y,CRLF) fappend outputfile
c=. >1{T
c2=.('.') chopstring c
c3=.>_1{ c2
('@SP',CRLF,'M=M-1',CRLF,'A=M',CRLF,'D=M',CRLF,'@',filename,'.', c3,CRLF,'D;JNE',CRLF)fappend outputfile
case. 'function' do.
('//',y,CRLF) fappend outputfile
k=. >2{ T
n=.".k
c=. >1{T
c2=.('.') chopstring c
c3=.>_1{ c2
('(',filename,'.', c3,')',CRLF) fappend outputfile
for_x.i.n do.
('@SP',CRLF,'A=M',CRLF,'M=0',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
end.
case. 'return' do.
('//',y,CRLF) fappend outputfile
('@LCL',CRLF,'D=M',CRLF,'@5',CRLF,'A=D-A',CRLF,'D=M',CRLF,'@13',CRLF,'M=D',CRLF,'@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@ARG',CRLF,'A=M',CRLF,'M=D',CRLF,'//SP=ARG+1',CRLF,'@SP',CRLF,'M=M-1',CRLF,'@ARG',CRLF,'D=M',CRLF,'@SP',CRLF,'M=D+1',CRLF,'//THAT=FRAME-1',CRLF,'@LCL',CRLF,'M=M-1',CRLF,'A=M',CRLF,'D=M',CRLF,'@THAT',CRLF,'M=D',CRLF,'//THIS=FRAME-2',CRLF,'@LCL',CRLF,'M=M-1',CRLF,'A=M',CRLF,'D=M',CRLF,'@THIS',CRLF,'M=D',CRLF,'//ARG=FRAME-3',CRLF,'@LCL',CRLF,'M=M-1',CRLF,'A=M',CRLF,'D=M',CRLF,'@ARG',CRLF,'M=D',CRLF,'//LCL=FRAME-4',CRLF,'@LCL',CRLF,'M=M-1',CRLF,'A=M',CRLF,'D=M',CRLF,'@LCL',CRLF,'M=D',CRLF,'@13',CRLF,'A=M',CRLF,'0; JMP',CRLF) fappend outputfile
case. 'call' do.
('//',y,CRLF) fappend outputfile
tag=.":>1 { T
c=.".>2 { T
c=. c +5
n=.":c
c8=.":counter2
('@',filename,'.',tag,'.','ReturnAddress',c8,CRLF,'D=A',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF,'//save LCL',CRLF,'@LCL',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF,'//save ARG',CRLF,'@ARG',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF,'//save THIS',CRLF,'@THIS',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF,'//save THAT',CRLF,'@THAT',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF,'@SP',CRLF,'D=M',CRLF,'@',n,CRLF,'D=D-A',CRLF,'@ARG',CRLF,'M=D',CRLF,'@SP',CRLF,'D=M',CRLF,'@LCL',CRLF,'M=D',CRLF,'@',tag,CRLF,'0; JMP',CRLF,'(',filename,'.',tag,'.','ReturnAddress',c8,')',CRLF)fappend outputfile
counter2=:counter2+1
case. 'add' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'A=A-1',CRLF,'M=M+D',CRLF,'@SP',CRLF,'M=M-1',CRLF) fappend outputfile
case. 'sub' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'A=A-1',CRLF,'M=M-D',CRLF,'@SP',CRLF,'M=M-1',CRLF) fappend outputfile
case. 'neg' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'M=-D',CRLF) fappend outputfile
case. 'eq' do.
('//',y,CRLF) fappend outputfile
count=.": counter
 ('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'A=A-1',CRLF,'D=D-M',CRLF,'@IF_TRUE',counter,CRLF,'D;JEQ',CRLF,'D=0',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'@IF_FALSE',counter,CRLF,'0;JMP',CRLF,'(IF_TRUE',counter,')',CRLF,'D=-1',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'(IF_FALSE',counter,')',CRLF,'@SP',CRLF,'M=M-1',CRLF) fappend outputfile
counter=:counter+1
case. 'gt' do.
('//',y,CRLF) fappend outputfile
count=.": counter
 ('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'A=A-1',CRLF,'D=M-D',CRLF,'@IF_TRUE',counter,CRLF,'D;JGT',CRLF,'D=0',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'@IF_FALSE',counter,CRLF,'0;JMP',CRLF,'(IF_TRUE',counter,')',CRLF,'D=-1',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'(IF_FALSE',counter,')',CRLF,'@SP',CRLF,'M=M-1',CRLF) fappend outputfile
counter=:counter+1
case. 'lt' do.
('//',y,CRLF) fappend outputfile
count=.": counter
 ('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'A=A-1',CRLF,'D=M-D',CRLF,'@IF_TRUE',count,CRLF,'D;JLT',CRLF,'D=0',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'@IF_FALSE',count,CRLF,'0;JMP',CRLF,'(IF_TRUE',count,')',CRLF,'D=-1',CRLF,'@SP',CRLF,'A=M-1',CRLF,'A=A-1',CRLF,'M=D',CRLF,'(IF_FALSE',count,')',CRLF,'@SP',CRLF,'M=M-1',CRLF) fappend outputfile
counter=: counter+1
case. 'and' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'M=M-1',CRLF,'@SP',CRLF,'A=M',CRLF,'D=M',CRLF,'@SP',CRLF,'M=M-1',CRLF,'@SP',CRLF,'A=M',CRLF,'D=D&M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile 
case. 'or' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'M=M-1',CRLF,'@SP',CRLF,'A=M',CRLF,'D=M',CRLF,'@SP',CRLF,'M=M-1',CRLF,'@SP',CRLF,'A=M',CRLF,'D=D|M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'not' do.
('//',y,CRLF) fappend outputfile
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'M=!D',CRLF) fappend outputfile
case. 'push' do.
('//',y,CRLF) fappend outputfile
pushHandle y
case. 'pop' do.
('//',y,CRLF) fappend outputfile
popHandle y
end.
y=.next__exemple''
end.
)
pushHandle=:monad define
T=.(' ') chopstring y
choise=. >1 { T
c=. >2 { T
g=.".c
select. choise
case. 'local' do.
('@',c,CRLF,'D=A',CRLF,'@LCL',CRLF,'A=M+D',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'argument' do.
('@',c,CRLF,'D=A',CRLF,'@ARG',CRLF,'A=M+D',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'this' do.
('@',c,CRLF,'D=A',CRLF,'@THIS',CRLF,'A=M+D',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'that' do.
('@',c,CRLF,'D=A',CRLF,'@THAT',CRLF,'A=M+D',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'temp' do.

calculate=.g+5
out=.":calculate
('@',out,CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'static' do.
('@',filename,'.',c,CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
case. 'pointer' do.
if. g=0 do.
('@THIS',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
else.
('@THAT',CRLF,'D=M',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
end.
case. 'constant' do.
('@',c,CRLF,'D=A',CRLF,'@SP',CRLF,'A=M',CRLF,'M=D',CRLF,'@SP',CRLF,'M=M+1',CRLF) fappend outputfile
end.
)

popHandle=:monad define
T=.(' ') chopstring y
k=. >2{ T
n=.".k
choice=. >1 { T
select. choice
case. 'local' do.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@LCL',CRLF, 'A=M' ,CRLF)fappend outputfile
for_x.i.n do.
('A=A+1',CRLF) fappend outputfile
end.
('M=D',CRLF,'@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
case. 'argument' do.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@ARG',CRLF, 'A=M' ,CRLF)fappend outputfile
for_x.i.n do.
('A=A+1',CRLF) fappend outputfile
end.
('M=D',CRLF,'@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
case. 'this' do.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@THIS',CRLF, 'A=M' ,CRLF)fappend outputfile
smoutput n
for_x.i.n do.
('A=A+1',CRLF) fappend outputfile
end.
('M=D',CRLF,'@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
case. 'that' do.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@THAT',CRLF, 'A=M' ,CRLF)fappend outputfile
for_x.i.n do.
('A=A+1',CRLF) fappend outputfile
end.
('M=D',CRLF,'@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
case. 'temp' do.
calculate=.n+5
out=.":calculate
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@',out,CRLF, 'M=D' ,CRLF, '@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
case. 'static' do.
c=. >2 { T
 ('@SP',CRLF,'M=M-1',CRLF,'@SP',CRLF,'A=M',CRLF,'D=M',CRLF,'@',filename,'.', c,CRLF,'M=D',CRLF) fappend outputfile
case. 'pointer' do.
if. n=0 do.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@THIS',CRLF, 'M=D' ,CRLF, '@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
else.
('@SP',CRLF,'A=M-1',CRLF,'D=M',CRLF,'@THAT',CRLF, 'M=D' ,CRLF, '@SP' ,CRLF,'M=M-1',CRLF) fappend outputfile
end.
end.
)
NB.main
counter=:0
filename=:' '
NB. put here the path of the field
path=:'C:\Users\USER\Desktop\Exercises\Targil2\project 08\FunctionCalls\FibonacciElement'
y =.('\') chopstring path
dirName=. _1 { y
temp=. > dirName
outputfile=: path ,'\',temp,'.asm'
('@256',CRLF,'D=A' ,CRLF,'@SP',CRLF,'M=D',CRLF) fappend outputfile
ls=. 1 dir path
NB. Find the vm file
suffix ls

