package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%
// ============================================================
// Definitions
// ============================================================

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}

%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
Identation = [ \t\f]

Plus = "+"
Mult = "*"
Sub = "-"
Div = "/"
Assig = "="
OpenBracket = "("
CloseBracket = ")"
OpenSquare = "["
CloseSquare = "]"
OpenCurly = "{"
CloseCurly = "}"
Semicolon = ";"
LE = "<="
GE = ">="
LT = "<"
GT = ">"
Inc = "++"
EQ = "=="
NE = "!="
Letter = [a-zA-Z]
Digit = [0-9]

WhiteSpace = {LineTerminator} | {Identation}
Identifier = {Letter} ({Letter}|{Digit})*
IntegerConstant = {Digit}+

%%
// ============================================================
// Rules
// ============================================================
<YYINITIAL> {
	/* keywords */
	"public"	{ return symbol(ParserSym.PUBLIC); }
	"static"	{ return symbol(ParserSym.STATIC); }
	"class" 	{ return symbol(ParserSym.CLASS); }
	"void"  	{ return symbol(ParserSym.VOID); }
	"int"   	{ return symbol(ParserSym.INT); }
	"for"   	{ return symbol(ParserSym.FOR); }
	"main"		{ return symbol(ParserSym.MAIN); }
	"String"	{ return symbol(ParserSym.STRING); }

	/* identifiers and constants */
	{Identifier}		{ return symbol(ParserSym.IDENTIFIER, yytext()); }
	{IntegerConstant}	{ return symbol(ParserSym.INTEGER_CONSTANT, yytext()); }

	/* operators */
	{Plus}        	{ return symbol(ParserSym.PLUS); }
	{Sub}         	{ return symbol(ParserSym.SUB); }
	{Mult}        	{ return symbol(ParserSym.MULT); }
	{Div}         	{ return symbol(ParserSym.DIV); }
	{Assig}       	{ return symbol(ParserSym.ASSIG); }
	{LE}          	{ return symbol(ParserSym.LE); }
	{GE}          	{ return symbol(ParserSym.GE); }
	{LT}          	{ return symbol(ParserSym.LT); }
	{GT}          	{ return symbol(ParserSym.GT); }
	{EQ}          	{ return symbol(ParserSym.EQ); }
	{NE}          	{ return symbol(ParserSym.NE); }
	{Inc}         	{ return symbol(ParserSym.INC); }

	/* delimiters */
	{Semicolon}		{ return symbol(ParserSym.SEMICOLON); }
	{OpenBracket}	{ return symbol(ParserSym.OPEN_BRACKET); }
	{CloseBracket}	{ return symbol(ParserSym.CLOSE_BRACKET); }
	{OpenCurly}		{ return symbol(ParserSym.OPEN_CURLY); }
	{CloseCurly}	{ return symbol(ParserSym.CLOSE_CURLY); }
	{OpenSquare}    { return symbol(ParserSym.OPEN_SQUARE); }
	{CloseSquare}   { return symbol(ParserSym.CLOSE_SQUARE); }

	/* comments */
	"//" {InputCharacter}* 			{ /* ignore */ }
	"/*"([^*]|\*+[^*/])*\*+"/"		{ /* ignore */ }

	/* whitespace */
	{WhiteSpace}	{ /* ignore */ }
}

/* error fallback */
[^]	{ throw new UnknownCharacterException(yytext()); }