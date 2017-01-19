/**
 * Define a grammar called Hello
 */

grammar ECL;

        ecl :  event+ policy + ;
      event : 'event' varName '=' '(' eID ',' varName ',' '[' attrConstrs']' ')' ;
attrConstrs :  attrConstr (',' attrConstr)* ;
 attrConstr :  attr ('['constrs']')? ;
      attr  :  varName ':' type ;
   constrs  : constr  
            | constr ('||' constr)*  
            | constr ('&&' constr)*
            ;
    constr  :  rop value ;
        eID : DIGITS  ;
      varName : ID ;
     value  :  ID   |   DIGITS  ;
       type : 'string'   |  'int'  |  'double' ;
     rop    : '<'   |  '>'   | '!='    |  '='   |  '>=' ;
     
      policy  :  'rule'  varName '=' tmf ;
       tmf  :  'always' emf  |  'exists' emf ;
       emf  :   f     
            |    f ('&' f)*   
            |   f ('+' f)* 
            |   econ 'when' emf 
            ;
       f   :  varName  
           |  'ors' '(' varName ')'
           |   'before' '(' tc ',' f ',' varName ',' econ ')'
           |   'after' '(' tc ',' varName ',' f ',' econ ')'
           |   'beforeSince''(' tc ',' f ',' f ',' varName ',' econ ')'
           |   'afterUntil''(' tc ',' varName ',' f ',' f ',' econ')'
           |  'seq''(' varNameList ')' 
           |  'occurOnce' '(' varName ')' 
           |  'exactAfter' '(' varName ',' varName ')'
           |  'occurTogether' '(' varName ',' varName ')'
           |  'bySameRole' '(' varName ',' varName ')'
           |  'notBySameRole' '(' varName ',' varName  ')'
           ;
varNameList : varName (',' varName)* ;
       
     econ  :  atom
           |   atom ('&&' atom)*
           ;
     atom  : varName'.'varName rop varName '.' varName  ;
       tc  : '(' left ',' right m ']' ;
       left : DIGITS ;
       right : DIGITS ;
       m :  'ms' | 's' | 'm' | 'h' | 'd'  ;
       
     
       

ID : [0-9a-zA-Z]+ ;             // match lower-case identifiers

DIGITS  : [0-9.]+ ;

WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines

