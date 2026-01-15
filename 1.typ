#import "template/lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let scheme = dark
#let edge = edge.with(stroke: scheme.fg, crossing-fill: scheme.bg)

#show: paper.with(scheme: scheme, title: "SEMPL", subtitle: "Part 1", author: "Paul-André Mellies' Course\nNotes by Lyes Saadi")

#let environment = environment.with(scheme: scheme)
#let environment_ = environment_.with(scheme: scheme)
#let theorem = environment.with(name: "Theorem")
#let definition = environment.with(name: "Definition")
#let exercise = environment.with(name: "Exercise")
#let proof = environment_.with(name: "Proof of", follows: true)

#outline()

= Course Organization <nonumber>

Paul-André Melliès

Website : `https://www.irif.fr/~mellies/mpri/mpri-m2/mpri-mellies-slides-1.pdf`
E-mail : `mellies@irif.fr`

= Introduction : $lambda$-calculus <nonumber>

There are two ways to work with $lambda$-calculus semantics:
- Denotational Semantics
- Operational Semantics

With two syntax evaluations:
- big step
- small step

And three strategies:
- call-by-name (CBN)
- call-by-value (CBV)
- call-by-need

And using Curry-Howard, we have a correspondance between proofs and programs.

With C, pointers allows you access memory without knowing all the details
behind it.

The course will mainly speak about semantics and points of view about programs.

The shift of C to Rust, and seperation logic were born from semantics.

How do we have access to god ?

= Domains and continuous functions

It's intuitionistic logic.

== Cartesian Closed Categories <nonumber>

Intuitionistic (minimal) logic.

It is deeply connected to the simply-typed $lambda$-calculus.

Domains

Can be seen as Domains = ordered set structure.

$A times B$, $A => B$. A type is a Domain.

== Introduction to domain theory

=== Category Theory

#let Hom = "Hom"

#definition(subtitle: "Category")[
  A category is a _class_ of vertices (called objects) and a set of edges
  (called maps or morphisms) equiped with a family of functions
  $compose : Hom(B, C) times Hom(A, B) -> Hom(A, C)$ with:
  1. An identity map $id_A in Hom(A, A)$ such that $id_A compose f = f$ and $g = g compose id_A$
  2. Associativity $h compose (g compose f) = (h compose g) compose f$
]

#environment(name: "Ad", counter: none)[
  1-2-3 october at the Institut Henri Poincaré

  URL : https://www.ihp.fr/en/events/bridging-linguistic-gap-between-mathematician-and-machine ?
]

#definition[
  The inf of $a$ and $b$ is an element $a and b$ such that:
  1. $a and b <= a$
  2. $a and b <= b$
  3. $forall x, x <= a and x <= b => x <= a and b$

  #diagram(
    node((0, 0), $a$),
    node((2, 0), $b$),
    node((1, 1), $a and b$),
    node((1, 2), $x$),
    edge((1, 1), (0, 0), "->"),
    edge((1, 1), (2, 0), "->"),
    edge((1, 2), (1, 1), "->"),
    edge((1, 2), (0, 0), "-->", bend: 20deg),
    edge((1, 2), (2, 0), "-->", bend: -20deg),
  )
]

#definition[
  A cartesian product of $A$ and $B$ is a triple $(A times B, A times B arrow.r^(pi_1) A, A times B arrow.r^(pi_2) B)$

  #diagram(
    node((0, 0), $A$),
    node((2, 0), $B$),
    node((1, 1), $A times B$),
    node((1, 2), $X$),
    edge((1, 1), (0, 0), "->", $pi_1$),
    edge((1, 1), (2, 0), "->", $pi_2$),
    edge((1, 2), (1, 1), "->", $h$),
    edge((1, 2), (0, 0), "-->", bend: 20deg),
    edge((1, 2), (2, 0), "-->", bend: -20deg),
  )
]

#definition[
  Given two objects $A$, $B$ in a category $C$, we define the category $"Span"(A, B)$:
  - whose objects are triples $(X, X ->^f A, X ->^g B)$
  - whose maps are $(X, X ->^f A, X ->^g B) -> (Y, Y ->^f A, Y ->^g B)$ is a
    map $h: X -> Y$ in the category $C$ such that $f_X = f_Y compose h$ and $g_X = g_Y compose h$.
]

#exercise[
  Show that $(A times B, pi_1, pi_2)$ is a cartesian product of $A$ and $B$ iff
  it is *terminal* in $bold("Span"(A, B))$.
]

= Coherence spaces and cliques

It's linear logic (Girard late 80's).

A type is a set of points (or states). M a program is among those points when
seen as a type.

Monoidal Closed Categories.

$(A -o B)^bot ~= (A (x) B)^bot$

Linear from A to B => One input produces one output.

$
    n |-> n + 1 &: NN -o NN\
    n |-> n + n &: !NN -o NN\
    f |-> sum^(f(7))_(i=0)(f(i)) &: !(NN -o NN) -o NN
$

= Dialogue games and strategies

heh

= Categories ?

#definition[
  A cartesian closed category (CCC) is a cartesian category $(cal(C), times, bb(1))$
  equipped for all $A, B$ objects of $cal(C)$ with an object $A => B$ and a map

  $
    "eval"_(A, B) : A times (A => B) --> B
  $

  Such that for all objects $C$ and for all maps

  $
    f : A times C --> B
  $

  there is a unique map

  $
    h : C --> (A => B)
  $

  such that the diagramm commute

  #align(center, diagram($
    A times (A => B) edge("->", label: "eval") &B\
    A times C edge("-->", "u", label: A times h) edge("->", "ur")
  $))
]

== Functors and natural transformations

#definition[
  A functor $F : cal(A) -> cal(B)$ between categories $cal(A), cal(B)$ is the
  data of an object $F A$ of $cal(B)$ for all objects $A$ of $cal(A)$, and a
  family of functions:
  $
    Hom_cal(A)(A, A') &--> Hom_cal(B)(F A, F A')\
    f : A --> A' &mapsto.long F f : F A --> F A'
  $
  Such that the composition law and identities are preserved.
]

#definition[
  Given two functiors $F, G : cal(A) --> cal(B)$,
  a natural transformation $theta : F => G$ is a family of maps
  $theta_A : F A --> G A$ indexed by objects $A$ of $cal(A)$.
]

#definition[
  If $cal(A)$ and $cal(B)$ are categories, $cal(A) times cal(B)$ whose
  objects are pairs, whose maps are pairs.
]

Claim : every cartesian category $(cal(C), times, bb(1))$ comes equipped with a
functor:
$
  times : &cal(C) times cal(C) --> cal(C)\
          &(A, B) mapsto A times B
$

#exercise[
  1. Show that $x times x$ defines a functor.
  2. Show that the functor $times : cal(C) times cal(C) --> cal(C)$ comes
    with two natural transformations.
    $
      phi_(A, B) : A times B ==>^(pi_1) A = "fst"(A, B)\
      psi_(A, B) : A times B ==>^(pi_2) B = "snd"(A, B)
    $
  3. $Delta_A : A --> A times A$
    #align(center, diagram({
       node((-2, 0), [$cal(C)$])
       node((0, 0), [$cal(C)$])
       node((-3, 0), [$A$])
       node((1, 0), [$A times A$])
       node((-1, -2), [$(A, A)$])
       node((-1, -1), [$cal(C) times cal(C)$])
       edge((-2, 0), (0, 0), [$"Id"$], label-side: right, "->", bend: -36deg)
       edge((-2, 0), (-1, -1), [$"diag"$], label-side: left, "->", bend: 18deg)
       edge((-1, -1), (0, 0), [$times$], label-side: left, "->", bend: 18deg)
       edge((-3, 0), (-1, -2), "|->", bend: 36deg)
       edge((-1, -2), (1, 0), "|->", bend: 36deg)
       edge((-3, 0), (1, 0), "|->", bend: -50deg)
       edge((-1, 0.4), (-1, -1), [$Delta$], label-side: right, "=>")
    }))
  4. $gamma_(A, B) : A times B --> B times A$
    #align(center, diagram({
       node((-2, 0), [$cal(C)$])
       node((0, 0), [$cal(C)$])
       node((-3, 0), [$A$])
       node((1, 0), [$A times A$])
       node((-1, -2), [$(A, A)$])
       node((-1, -1), [$cal(C) times cal(C)$])
       edge((-2, 0), (0, 0), [$"Id"$], label-side: right, "->", bend: -36deg)
       edge((-2, 0), (-1, -1), [$"diag"$], label-side: left, "->", bend: 18deg)
       edge((-1, -1), (0, 0), [$times$], label-side: left, "->", bend: 18deg)
       edge((-3, 0), (-1, -2), "|->", bend: 36deg)
       edge((-1, -2), (1, 0), "|->", bend: 36deg)
       edge((-3, 0), (1, 0), "|->", bend: -50deg)
       edge((-1, 0.4), (-1, -1), [$gamma$], label-side: right, "=>")
    }))
]

== Adjunctions

#environment(name: "Fact")[
  Every category $cal(C)$ comes equipped with a functor structure on the hom sets:
  $Hom_cal(C)(A, B)$.

  $
    Hom_cal(C) : &cal(C)^"op" times cal(C) --> &"Set"\
                 &(A, B)      mapsto.long &Hom_cal(C)(A, B)
                
  $ 
]

== Cartesian closed categories

#definition[
  1. Based on $"eval" : A times (A => B) --> B$
  2. Based on adjunctions :

  A cartesian closed category $cal(C)$ is closed when for all objects $A$ in $cal(C)$,
  the functor $A times \_ : &cal(C) --> cal(C)\ &B mapsto.long A times B$ has a right
  adjoint $A_(=>) : &cal(C) --> cal(C)\ &B mapsto.long A => B$.

  The two definitions are equivalent.

  Given definition 2, we want to recover the family of maps $"eval" : A times (A => B) --> B$.
]

#environment_(name: "Geneal facts about adjunctions", counter: none)[
  // #diagram($
  //   "Set" edge(->, label: "Free") edge(<-, label: "Forgetful") &"Mon"
  // $)
  Example 1 :

  #align(center, diagram({
   node((0, 0), [$"Set"$])
   node((1, 0), [$"Mon"$])
   node((.5, 0), [$bot$])
   edge((0, 0), (1, 0), [Free], label-side: left, shift: 0.2, "->")
   edge((1, 0), (0, 0), [Forgetful], label-side: left, shift: 0.2, "->")
  }))

  $
    "Set"(A, M)\
    tilde.equiv\
    "Mon"(A^*, (M, eta, mu))
  $

  Example 2 :

  #align(center, diagram({
   node((0, 0), [$"Set"$])
   node((1, 0), [$"Set"$])
   node((.5, 0), [$bot$])
   edge((0, 0), (1, 0), [$A times \_$], label-side: left, shift: 0.2, "->")
   edge((1, 0), (0, 0), [$A => \_$], label-side: left, shift: 0.2, "->")
  }))

  $
    "Set"(A times B, C)\
    tilde.equiv\
    "Mon"(A, B => C)
  $

  It's currification.

  General case :

  #align(center, diagram({
   node((0, 0), [$A$])
   node((1, 0), [$B$])
   node((.5, 0), [$bot$])
   edge((0, 0), (1, 0), [$L$], label-side: left, shift: 0.2, "->")
   edge((1, 0), (0, 0), [$R$], label-side: left, shift: 0.2, "->")
  }))

  Suppose $L : A --> B$ left adjoint to $R : B --> A$

  In that case, there exists families of maps / arrows
  $eta : A --> R L A$ (unit of the adjonction) and $epsilon : L R B --> B$
  (co unit of the adjunction).

  *Adjunction* $L tack.l R : cal(B)(L -, =) tilde.equiv cal(A)(-, R =)$

  $Phi_(A, B) : cal(B)(L A, B) tilde.equiv cal(A)(A, R B)$ (natural in A and B)

  $B = L A : cal(B)(L A, L A) tilde.equiv cal(A)(A, R L A)$ ($eta_A = Phi_(A, L A)(id_(L A))$)

  $A = R B : cal(B)(L R B, B) tilde.equiv cal(A)(R B, R B)$ ($epsilon_B = Phi^(-1)_(R B, B)(id_(R B))$)

  #align(center, diagram({
   node((0, -1), [$cal(A)^(op) times cal(B)$])
   node((0, 1), [$"Set"$])
   node((-1, 0), [$cal(A)^op times cal(A)$])
   node((1, 0), [$cal(B)^op times cal(B)$])
   node((2, 0), [$(L A, B)$])
   node((-2, 0), [$(A, R B)$])
   edge((0, -1), (-1, 0), [$\_ times R$], label-side: right, "->")
   edge((0, -1), (1, 0), [$L^op times \_$], label-side: left, "->")
   edge((-1, 0), (0, 1), [$"Hom"_cal(A)$], label-side: right, "->")
   edge((1, 0), (0, 1), [$"Hom"_cal(B)$], label-side: left, "->")
   edge((1, 0), (-1, 0), "=>")
  }))

  $eta$ is a natural transformation :

  #align(center, diagram({
   node((-1, -1), [$A$])
   node((0, -1), [$R L A$])
   node((-1, 0), [$A'$])
   node((0, 0), [$R L A'$])
   edge((-1, -1), (0, -1), [$eta_A$], label-side: left, "->")
   edge((-1, -1), (-1, 0), [$h$], label-side: right, "->")
   edge((0, -1), (0, 0), [$R L h$], label-side: left, "->")
   edge((-1, 0), (0, 0), [$epsilon_A'$], "->")
  }))

  Which commutes for all $h : A --> A'$.

  #align(center, diagram({
   node((-1, -1), [$L R B$])
   node((0, -1), [$B$])
   node((-1, 0), [$L R B'$])
   node((0, 0), [$B'$])
   edge((-1, -1), (0, -1), [$epsilon_B$], label-side: left, "->")
   edge((-1, -1), (-1, 0), [$L R h$], label-side: right, "->")
   edge((0, -1), (0, 0), [$h$], label-side: left, "->")
   edge((-1, 0), (0, 0), [$epsilon_B'$], label-side: right, "->")
  }))

  Which commutes for all $h : B --> B'$.

  We have $eta : "Id"_cal(A) => R compose L$ and $epsilon : L compose R => "Id"_cal(B)$.

  #align(center, diagram({
   node((-1, -1), [$cal(A)$])
   node((1, -1), [$cal(A)$])
   node((0, 0), [$cal(B)$])
   node((0, -2))
   edge((-1, -1), (1, -1), [$"Id"_cal(A)$], label-side: left, "->", bend: 54deg)
   edge((-1, -1), (0, 0), [$L$], label-side: right, "->", bend: -18deg)
   edge((0, 0), (1, -1), [$R$], label-side: right, "->", bend: -18deg)
   edge((0, -1.5), (0, 0), [$eta$], label-side: left, "=>")
  }))

  Back to example 1 :

  A a set,

  $eta_A : A &--> A^*\ a &mapsto.long [a]$

  M a monoid,

  $"eval"_M = epsilon_M ; M^* &--> M\ [m_1, ..., m_k] &mapsto.long m_A ⋅ ... ⋅ m_k$

  Back to example 2 :

  unit of $A times \_ tack.l A => \_$ is a CCC.

  $eta^A_B : B &--> (A => (A times B))\ b &mapsto.long (a mapsto (A, B))$ (it's coeval)

  counit of $A times \_ tack.l A => \_$ is a CCC.

  $epsilon^A_B ; (A times (A => B)) &--> B\ (a, f) &mapsto.long f(A)$ (it's eval)
]

== Coherence Categories

Category *Coh* :
$
  f : A --> B
$
is a relation
$
  f subset.eq |A| times |B|
$
such that :
$
  forall (a, b) in f, (a', b') in f, a "coh"_A a' => b "coh"_B b' => a "ncoh"_A a'
$
i.e., $f$ is a clique of $A -> B$.

$f : 1 -> A$ is a clique of A.

$g : A -> bot tilde.eq 1$ an anticlique of $A$ <=> a clique of $A multimap bot tilde.eq A^bot$.

#align(center, diagram({
	node((-3, -1), [$A$])
	node((-5, -1), [$1$])
	node((-1, -1), [$bot tilde.equiv 1$])
	node((-6, -1), [$*$])
	node((0, -1), [$*$])
	edge((-5, -1), (-3, -1), [$f "(clique)"$], label-side: left, "->")
	edge((-3, -1), (-1, -1), [$g "(anti clique)"$], label-side: left, "->")
	edge((-5, -1), (-1, -1), "->", bend: -30deg)
	edge((-6, -1), (-5, -1), [$in$], label-side: center, " ")
	edge((0, -1), (-1, -1), [$in.rev$], label-side: center, " ")
}))

=== Categorical structure of *Coh*

==== The cartesian product of A and B

#align(center, diagram({
	node((-1, -1), [$A \& B$])
	node((-2, -2), [$A$])
	node((0, -2), [$B$])
	node((-1, 1), [$X$])
	edge((-1, 1), (-1, -1), [$exists!h$], label-side: center, "-->")
	edge((-1, -1), (-2, -2), [$pi_1$], label-side: center, "->")
	edge((-1, -1), (0, -2), [$pi_2$], label-side: center, "->")
	edge((-1, 1), (-2, -2), [$f$], label-side: center, "->", bend: 18deg)
	edge((-1, 1), (0, -2), [$g$], label-side: center, "->", bend: -18deg)
}))

$
  &pi_1 = {("inl" a, a) | a in |A|}\
  &pi_2 = {("inr" b, b) | b in |B|}\
  &|A \& B| = {"inl" a | a in |A|} union.plus {"inr" b | b in |B|}\
  &"given" f : X -> A "and" g : X -> B\
  &h = {(x, "inl" a) | (x, a) in f} union.plus {(x, "inr" b) | (x, b) in f}
$

Why is $h$ a clique ?

terminal object : empty clique

==== The category of Coh is cartesian, but not cartesian closed

#import "@preview/pinit:0.2.2": *

$
  pin("1") A \& B --> C pin("2")
$

#pinit-highlight("1", "2", fill: blue.transparentize(75%))
#pinit-point-from("2", "No way to currify", offset-dy: 10pt, body-dy: 0pt, fill: white)

==== On the other hand, there is a bijection

$
  "Coh"(A (times) B, C) tilde.eq "Coh"(B, A -o C)
$

=== Exponentials in coherence spaces and linear logic

#let coh = "⁐"
#let ncoh = "ncoh"

$!A "has web" |!A|$ defined as the set of finite clique

$coh_(A!)$ when
1. $exists w$ a finite clique $u, v subset.eq w$.
2. (equiv) $forall a in u, forall tau' in v$, $a coh_(A!) a'$

==== Two main structures

$!A$ defines a _commutative comonoid_ in Coh.

#definition[
  A monoid $(M, m, e)$ in a monoidal category $(cal(C), (times), bb(1))$ is an object
  $M$ of $cal(C)$ equipped with two maps :

  $m : M times M --> M$ $e : bb(1) --> M$

  #align(center, diagram({
  	node((0, 0), [$M times M times M$])
  	node((1, 0), [$M times M$])
  	node((0, 1), [$M times M$])
  	node((1, 1), [$M$])
  	node((3, 0), [$M$])
  	node((4, 0), [$bb(1) times M$])
  	node((4, 1), [$M times M$])
  	node((6, 0), [$M$])
  	node((7, 0), [$M times bb(1)$])
  	node((7, 1), [$M times M$])
  	edge((0, 0), (1, 0), [$M times m$], label-side: left, "->")
  	edge((0, 0), (0, 1), [$m times M$], label-side: right, "->")
  	edge((0, 1), (1, 1), [$m$], label-side: right, "->")
  	edge((1, 0), (1, 1), [$m$], label-side: left, "->")
  	edge((3, 0), (4, 0), [$lambda^(-1)_M$], "->")
  	edge((4, 0), (4, 1), [$e times M$], label-side: left, "->")
  	edge((4, 1), (3, 0), [$m$], label-side: left, "->")
  	edge((7, 1), (6, 0), [$m$], label-side: left, "->")
  	edge((7, 0), (7, 1), [$M times e$], label-side: left, "->")
  	edge((6, 0), (7, 0), [$lambda^(-1)_M$], "->")
  }))

  #align(center, diagram({
  	node((3, 0), [$M$])
  	node((3, 1), [$M$])
  	edge((3, 0), (3, 1), [$id$], label-side: right, "->", bend: -36deg)
  	edge((3, 0), (3, 1), [$m compose (e times M) compose lambda^(-1)_M$], label-side: left, "->", bend: 36deg)
  }))
]

#definition[
  A comonoid in $(cal(C), (times), bb(A))$ is a monoid in the opposite monoidal category
  $(cal(C)"op", (times), bb(1))$.

  $d : M --> M (times) M$ $u : M --> bb(1)$

  #align(center, diagram({
  	node((1, 0), [$M$])
  	node((2, 0), [$M times.o M$])
  	node((2, 1), [$M times.o M times.o M$])
  	node((1, 1), [$M times.o M$])
  	node((4, 0), [$M times.o M$])
  	node((4, 1), [$bb(1) times.o M$])
  	node((5, 0), [$M$])
  	node((6, 0), [$M times.o M$])
  	node((6, 1), [$M times.o bb(1)$])
  	edge((1, 0), (2, 0), [$d$], label-side: left, "->")
  	edge((1, 0), (1, 1), [$d$], label-side: right, "->")
  	edge((1, 1), (2, 1), [$M times.o d$], label-side: right, "->")
  	edge((2, 0), (2, 1), [$M times.o d$], label-side: left, "->")
  	edge((5, 0), (4, 0), [$d$], label-side: right, "->")
  	edge((5, 0), (6, 0), [$d$], label-side: left, "->")
  	edge((4, 0), (4, 1), [$u times.o M$], label-side: right, "->")
  	edge((6, 0), (6, 1), [$M times.o u$], label-side: left, "->")
  	edge((4, 1), (5, 0), [$lambda_M$], label-side: right, "->")
  	edge((6, 1), (5, 0), [$Gamma_M$], label-side: left, "->")
  }))

  #align(center, diagram({
  	node((1, 0), [$!A$])
  	node((2, 0), [$!A times.o !A$])
  	node((1, 1), [$!A times.o !A$])
  	node((2, 1), [$!A times.o !A times.o !A$])
  	edge((1, 0), (2, 0), [$d_A$], label-side: left, "->")
  	edge((1, 0), (1, 1), [$d_A$], label-side: right, "->")
  	edge((1, 1), (2, 1), [$!A times.o d_A$], label-side: right, "->")
  	edge((2, 0), (2, 1), [$d_A times.o !A$], label-side: left, "->")
  	edge((1, 0), (2, 1), [$d_a times.o d_a$], label-side: center, "->")
  }))
]

#definition[
  A commutative monoid in a symmetric monoidal category is a monoid $(M, m, e)$
  such that this commutes :
  #align(center, diagram({
  	node((1, 0), [$M times.o M$])
  	node((2, .5), [$M$])
  	node((1, 1), [$M times.o M$])
  	edge((1, 0), (2, .5), [$m$], label-side: left, "->")
  	edge((1, 1), (2, .5), [$m$], label-side: right, "->")
  	edge((1, 0), (1, 1), [$gamma_(M,M)$], label-side: right, "->")
  }))

  By duality, a commutative comonoid :
  #align(center, diagram({
  	node((2, 0), [$M times.o M$])
  	node((1, .5), [$M$])
  	node((2, 1), [$M times.o M$])
  	edge((1, .5), (2, 0), [$d_m$], label-side: left, "->")
  	edge((1, .5), (2, 1), [$d_m$], label-side: right, "->")
  	edge((2, 0), (2, 1), [$gamma_(M,M)$], label-side: right, "->")
  }))
]

#definition[
  A monad is a monoid in the category of endofunctors.

  A monad $T : cal(C) --> cal(C)$ is a functor equipped with a pair of natural
  transformations.

  $
    eta_A : A --> A quad mu_A : T T A --> T A
  $
]

#definition[
  A comonad $K: cal(C) --> cal(C)$ on $cal(C)$ is defined as a monad on $cal(C)op$.

  $
    delta_A : A --> A quad epsilon_A : K A --> A
  $
]


The exponential modality $!$ as a comonad $! : "Coh" --> "Coh"$ defines a functor.

$
  [f : A --> B] mapsto.long [! f : !A --> !B]
$

$f$ a clique of $A -o B$.

$
  !f = { (u, v) cases(forall a in u\, exists b in v \, (a\, b) in f, forall b in v\, exists a in u \, (a\, b) in f, delim: "|") }
$

$
  delta_A = {(u, {v_1, ..., v_n}) | u = v_1 union ... union v_n} "(each "v_i" is a finite clique of "A")"
$

$
  epsilon_A = {({a}, a)}
$

Intuitionistic linear logic :
$
  A_1, ..., A_n tack B arrow.r.squiggly.long [A_1] (times) ... (times) [A_n] --> [B]
$

Contraction : $(Gamma, !A, !A tack B)/(Gamma, !A tack B)$ which is $!A -->^(d_A) !A (times) !A$

Weakening : $(Gamma tack B)/(Gamma, !A tack B)$ which is $!A -->^(u_A) bb(1)$

Dereliction : $(Gamma, A tack B)/(Gamma, !A tack B)$ which is $!A -->^(epsilon_A) A$

Digging : $(!A_1, ..., !A_n tack B)/(!A_1, ..., !A_n tack !B)$

Which is $!A -->^(delta_A) !!A$ and $!A (times) !B tilde.equiv !(A \& B)$

$
  !(A \& A') tilde.equiv !A (times) !A' &-->f B\
  !!(A \& A') tilde.equiv !A (times) !A' &-->^(!f) !B
$
