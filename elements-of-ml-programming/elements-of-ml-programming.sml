(*Elements of ML programming*)

(*Exercises 3.1.1*)
fun cubereal x = x*x*x;

fun smallestofthree (a,b,c)=if (a<=b andalso a<=c) then a else
			    if b<=c then b else c;

fun thirdoflist (list) = hd (tl (tl list));

fun revtuple3 (a,b,c) = (c,b,a);

fun thirdcharofstr str= thirdoflist (explode str);

fun cyclelistonce list= (tl list)@((hd list)::nil);

(*Exercises 3.1.2*)
(*a,b,c missing*)
fun secondeldeleted list = (hd list)::(tl (tl list));

(*Chapter 3.2*)
fun reverse L= if L=nil then nil else
	       (reverse (tl L))@((hd L)::nil);

fun comb (n,m) = if (m=0 orelse n=m) then 1
		 else comb(n-1,m) + comb(n-1, m-1);

fun takeoddpos L=
  if L=nil then nil else
  (hd L)::(takeevenpos(tl L))

and
takeevenpos L=
if L=nil then nil else
takeoddpos(tl L);

(*Exercises 3.2.1*)
fun cyclelistn (L, n:int)=
  if n=0 then L
  else if n=1 then cyclelistonce L
  else cyclelistn (cyclelistonce L,n-1);


fun listlength L=
  if L=nil then 0
  else 1+listlength (tl L);

fun mergesmallestfirst (nil, M)= M
  | mergesmallestfirst (L, nil) = L
  | mergesmallestfirst (L as fL::rL, M as fM::rM) =
    if fL <= fM then fL::(mergesmallestfirst (rL,M))
    else fM::(mergesmallestfirst (L,rM));

fun sumPairs(nil)=0
  | sumPairs (nil::otherLists) = sumPairs(otherLists)
  | sumPairs ((x::xs)::otherLists) = x+sumPairs(xs::otherLists);

fun hundrethPower(x:real)=
  let
      val five=x*x*x*x*x;
      val tfive=five*five*five*five*five;
  in
      tfive*tfive*tfive*tfive
  end;

fun split(nil)=(nil,nil)
  | split (a::nil) = ([a],nil)
  | split (a::b::cs) =
    let
	val (M,N)=split(cs)
    in
	(a::M,b::N)
    end;

fun mergesort (nil)=nil
  | mergesort (a::nil) = [a]
  | mergesort (L) =
    let
	val (M,N)=split(L);
    in
	mergesmallestfirst(mergesort M,mergesort N)
    end;

(*Exercises 3.4.5*)
(*skipped*)

fun rev1 (nil,M) = M (*usage: rev1([5,4,3,2,1],nil)*)
  | rev1(x::xs,M)=rev1(xs,x::M); 

fun printList(nil)=nil
  | printList (x::xs) = (
      print(Int.toString(x));
      print("\n");
      printList(xs)
  );

fun readList(infile)=
  if endOfStream(infile)=true then nil
  else inputN(infile,1)::readList(infile);


fun makeList1(infile,NONE)=nil
  | makeList1 (infile,SOME c) = c::makeList1(infile,input1(infile));

fun makeList(infile)=
      makeList1(infile,input1(infile));

(*Chapter 5*)

val rec reverse = fn
		 nil => nil
   |x::xs => reverse(xs)@[x];

val addOne = fn
	    x => x+1;

val double_crazy = fn 0 => 10 | x => 2*x;

fun double_crazy x = case x of
			 0 => 10 
		       | x => 2*x;


(*Exercise 5.1.2*)



val rec sumPairs=fn nil => 0 | (x,y)::xs => x+y+sumPairs(xs);

fun sumPairs x = case x of
		     nil => 0
		   | (x,y)::xs => x+y+sumPairs(xs);

fun printList(nil)=nil
  | printList (x::xs) = (
      print(Int.toString(x));
      print("\n");
      printList(xs)
  );

val rec printList = fn
		   nil => nil
  | (x::xs) => (
      print(Int.toString(x));
      print("\n");
      printList(xs)
  );

fun printlist x = case x of
		      nil => nil
		    | x::xs => (
			print(Int.toString(x));
			print("\n");
			printList(xs)
		    );

val rec mergePartiallySorted = fn
			      (nil,M) => M
					     |(L,nil) => L
   |(L as x::xs, M as y::ys) => if x<y then x::mergePartiallySorted(xs,M) else
				y::mergePartiallySorted(L,ys);

fun mergePartiallySorted (L,M) = case (L,M) of
				     (nil,M) => M
				   | (L,nil) => L
				   | (L as x::xs, M as y::ys) => if x<y then x::mergePartiallySorted(xs,M) else
								 y::mergePartiallySorted(ys,L);

val rec comb = fn
	      (_,0)=>1
   |(n,m) => if n=m then 1 else
	     comb(n-1,m) + comb(n-1,m-1);

fun comb (n,m) = case (n,m) of
		     (_,0) => 1
		   | (n,m) => if n=m then 1 else
			      comb(n-1,m)+comb(n-1,m-1);

(*Exercise 5.1.4*)

(*Chapter 5.4*)

fun trap(a,b,n,F)= if b-a < 0.0 orelse n < 0
		   then 0.0
		   else
		       if b-a <= 0.0 orelse n=0
		       then 0.0
		       else let
			   val width = (b-a)/real(n);
			   val avgheigth = (F(a)+F(a+width))/2.0;
		       in
			   width*avgheigth+trap(a+width,b,n-1,F)
		       end;

fun simpleMap(F,nil)=nil
  | simpleMap (F,x::xs)= F(x)::simpleMap(F,xs); 

fun reduce(F,x::nil)=x
  | reduce (F,x::xs) = F(x,reduce(F,xs));

fun filter(P,nil)=nil
  | filter (P,x::xs) = if P(x)
		       then x::filter(P,xs)
		       else filter(P,xs);

fun exponent1(x,0)=1.0
  | exponent1 (x,n) = x*exponent1(x,n-1);

fun exponent2 x 0=1.0
  | exponent2 x n = x*(exponent2 x (n-1));

(*exercises 5.5.3*)

fun applyList ListOfFunc InVal= case ListOfFunc of
				    nil => nil
				  | x::xs => x(InVal)::(applyList xs InVal);

fun makeFnList F = (* creates a function that will converts a list into a list of Functions, where each function is F applied to the original list. USAGE:
makeFnList Function List will return  you a list of functions. Free variables of functions are all except the first, ie, the first is consumed applied to the list*)
  let
      val rec G = fn
		 nil => nil
	 |(d::ds) => F(d)::(G ds)
  in
      G
  end;

fun substring x y= (*checks if x is a substring of y*)
  let
      val xList1=explode(x);
      val yList1=explode(y);
      fun ss(xList,yList)=case (xList, yList) of
		      (nil,_) => true
		    | (_,nil) => false
		    | (x::xs,y::ys) => if x=y then
					   if ss(xs,ys)
					   then true
					   else false
				       else ss(x::xs,ys)
  in
      ss(xList1, yList1)
  end;

fun funf Lstr= (*should be updated to use makeFnList*)
    let
	val rec C = fn
	       nil => nil
	   |x::xs => (substring x)::(C xs)
    in
	C Lstr
    end;

fun funf2 Lstr = makeFnList (substring) Lstr;

applyList (funf2 ["he", "she", "her", "his"]) "hershey";

fun comp(G,F,x)=G(F(x));

fun comp2 G F =
  fn x=> G(F(x));

(*Chapter 6.2*)

datatype ('a, 'b) element=
	 P of 'a * 'b|
	 S of 'a;

fun sumElList(nil)=0
  | sumElList (S(x)::ss) = sumElList(ss)
  | sumElList (P(x,y)::ps) = y+sumElList(ps);

sumElList [P("in",6),S("hey"),P("a",1)];

datatype 'label bintree=
	 Empty| (*SOME vs EMPTY*)
	 Node of 'label * 'label bintree * 'label bintree;

val t = Node(
	"ML",
	Node("as",
	     Node("a",Empty,Empty),
	     Node("in",Empty,Empty)),
	Node("types",Empty,Empty));

datatype
'label eventree=
Empty|
Enode of 'label * 'label oddtree * 'label oddtree
and
'label oddtree=
Onode of  'label * 'label eventree * 'label eventree;

val t1=Onode(1,Empty,Empty);

val t2=Onode(2,Empty,Empty);

val t3=Enode(3,t1,t2);

(*case study 6.3*)



fun lower(nil)=nil
  | lower (c::cs) = (Char.toLower c)::lower(cs);

fun strLT(L,M)=
  let
      val Llower=implode(lower(explode L));
      val Mlower=implode(lower(explode M));
  in
      Llower < Mlower
  end;

fun lookup ltFun Empty x=false
  | lookup ltFun (Node(y, left, right)) x = if ltFun(x,y)
					    then (lookup ltFun left x)
					    else
						if ltFun(y,x)
						then (lookup ltFun right x)
						else true;

val t=Node("ML",
	   Node("as",
		Node("a",Empty,Empty),
	       Node("in",Empty,Empty)),
	   Node("types",Empty,Empty));

fun insert ltFun Empty x = Node(x,Empty,Empty)
  | insert ltFun (T as Node(y, left, right)) x = if ltFun(x,y)
						 then insert ltFun left x
						 else
						     if ltFun(y,x)
						     then insert ltFun right x
						     else T;

(* section 8.2.1*)

structure Mapping=struct

exception NotFound;

val create=nil;

fun lookup(d,nil)=raise NotFound
  | lookup (d,(e,r)::es) =
    if d=e
    then r
    else lookup(d,es);

fun insert (d,r,nil)=[(d,r)]
  | insert (d,r,(e,s)::es) =
    if d=e
    then (d,r)::es
    else (e,s)::insert(d,r,es)
		      

end;

signature SIMAPPING =
sig
    exception NotFound;
    val create : (string * int) list;
    val insert : string * int * (string * int) list -> (string * int) list;
    val lookup : string * (string * int) list -> int
end;

structure SiMapping: SIMAPPING = Mapping
