/*
 * Josef Ruzicka ... B87095
 * Carlos Solorzano Cerdas B87741
 * Javier Molina Herrera B84981
 * Alejandro Ramirez Montero B96367
 * */

 /*
  * Idea General:
  * Programamos un sistema experto en navegación Polinesia. La idea es que la persona se pare sobre
  * una coordenada del mapa que hicimos (la foto del mapa se incluye en el entregable en mediacion)
  * e ingresa en el sistema lo que puede divisar desde esta coordenada sobre la que se encuentra parado.
  * Lo ingresado en el sistema experto sería lo que puede divisar en las 8 coordenadas adyacentes a la
  * coordenada sobre la que se encuentra. En caso de que haya alguna coordenada vacía, no la tiene que
  * ingresar. El sistema experto procesa la información indgresada para determinar dónde se encuentra
  * el navegante. Seguidamente el sistema experto le dará una recomendación de qué dirección tomar para
  * llegar a tierra firme (la recomendación puede ser cualquiera de las 8 direcciones: norte, noreste,
  * este, sureste, sur, suroeste, oeste o noroeste) y qué más podrá divisar el navegante una vez que se
  * mueva en esa dirección. El navegante podrá, conestos datos, continuar preguntandole al sistema
  * qué dirección tomar para llegar a tierra firme.
  * 
  * Utilizar la consulta getNextMove ('Primer objeto que observa','Segundo objeto que observa',...,'Ultimo objeto que observa').
  * Para ingresar los objetos de las nuevas coordenadas.
  * 
  * 
  * Posibles Consultas: 
  * getNextMove('Dolphins','Reef','Reef'). 
  * getNextMove('Betelsgeuse Star', 'Dolphins', 'Samoa Island', 'Reef').
  * getNextMove('Reef', 'Seagulls','Reef').
  * 
  * Este ultimo query le indica al navegante que ya llegó a tierra firme.
  * 
  * 
  * 
  * El codigo de arriba establece que el navegante empieza en la coordenada 4,5 (pero el navegante no lo sabe)
  * y el sistema experto lo guía a llegar a la isla más cercana, en este caso la isla de Samoa en 5,3.
  * 
  * 
  * Places: Hawaii, Cook Island, French Polynesia, Samoa, Tonga
  * Stars: Sirius, RigelStar, 
  * Corrientes:
 * */

coordinate(0,0,'You arrived!').
coordinate(0,1,'Navigate West').
coordinate(0,2,'Navigate Southwest').
coordinate(0,3,'Navigate Southwest').
coordinate(0,4,'Navigate Southwest').
coordinate(0,5,'Navigate Southwest').

coordinate(1,0,'Navigate North').
coordinate(1,1,'Navigate Northwest').
coordinate(1,2,'Navigate West').
coordinate(1,3,'Navigate West').
coordinate(1,4,'Navigate West').
coordinate(1,5,'Navigate West').

coordinate(2,0,'Navigate Northeast').
coordinate(2,1,'Navigate North' ).
coordinate(2,2,'Navigate Northwest').
coordinate(2,3,'Navigate Northwest').
coordinate(2,4,'Navigate South').
coordinate(2,5,'Navigate Southwest').

coordinate(3,0,'Navigate North').
coordinate(3,1,'Navigate South').
coordinate(3,2,'Navigate East').
coordinate(3,3,'Navigate Southeast').
coordinate(3,4,'Navigate South').
coordinate(3,5,'Navigate Southwest').

coordinate(4,0,'Navigate East').
coordinate(4,1,'Navigate Southeast').
coordinate(4,2,'Navigate Southeast').
coordinate(4,3,'Navigate South').
coordinate(4,4,'Navigate Southwest').
coordinate(4,5,'Navigate West').

coordinate(5,0,'Navigate Northeast').
coordinate(5,1,'Navigate East').
coordinate(5,2,'Navigate East').
coordinate(5,3,'You arrived!').
coordinate(5,4,'Navigate West').
coordinate(5,5,'Navigate West').

/* De 1*/
vision('Reef',0,0).
vision('Whales',0,5).


/* De 2*/
vision('Seals','Whales',1,3).
vision('Whales','Migrant Birds',1,4).
vision('Whales', 'Whales',1,5).
vision('Whales','Dolphins',2,5).
vision('Dolphins','Reef',3,3).
vision('Betelsgeuse Star','Reef',3,4).
vision('Dolphins','Reef',3,5).
vision('Killer Whales','Seals',4,0).
vision('Migrant Birds','Seals',5,0).
vision('Seals','Seagulls',5,1).
vision('Seals','Samoa Island',5,2).
vision('Reef','Samoa Island',5,4).
vision('Reef','Reef',5,5).



/* De 3*/
vision('Tonga Island','Reef','Seals',0,1).
vision('Reef','Seals','Migrant Birds',0,2).
vision('Seals','Migrant Birds','Whales',0,3).
vision('Whales','Migrant Birds','Whales',0,4).
vision('Reef','Migrant Birds','Sirius Star',1,2).
vision('Reef','Sirius Star','Killer Whales',2,0).
vision('Killer Whales','Migrant Birds','Seagulls',4,1).
vision('Dolphins','Reef','Reef',4,5).
vision('Reef','Seagulls','Reef',5,3).


/* De 4*/
vision('Tonga Island','Reef','Cod','Sirius Star',1,0).
vision('Tonga Island','Seals','Cod','Sirius Star',1,1).
vision('Reef','Seals','Cod','Killer Whales',2,1).
vision('Migrant Birds','Whales','Betelsgeuse Star','Dolphins',2,4).
vision('Cod','Sirius Star','Migrant Birds','Seals',3,1).
vision('Sirius Star','Killer Whales','Betelsgeuse Star','Seals',3,2).
vision('Betelsgeuse Star','Dolphins','Samoa Island','Reef',4,4).


/* De 5*/
vision('Seals','Migrant Birds','Whales','Betelsgeuse Star','Dolphins',2,3).
vision('Cod','Sirius Star','Killer Whales','Migrant Birds','Seals',3,0).
vision('Killer Whales','Betelsgeuse Star','Seals','Seagulls','Samoa Island',4,2).


/* De 6*/
vision('Reef','Seals','Migrant Birds','Sirius Star','Killer Whales','Betelsgeuse Star',2,2).
vision('Betelsgeuse Star','Dolphins','Reef','Seagulls','Samoa Island','Reef',4,3).


calculateNewCoordinate(X,Y,Z,W, V):-
    Z == 'Navigate North' -> W is X - 1, V is Y;
    Z == 'Navigate South' -> W is X + 1, V is Y;
	Z == 'Navigate East' -> W is X, V is Y + 1;
    Z == 'Navigate West' -> W is X, V is Y - 1;

    Z == 'Navigate Northeast' -> W is X - 1, V is Y + 1;
    Z == 'Navigate Northwest' -> W is X - 1, V is Y - 1;
	Z == 'Navigate Southeast' -> W is X + 1, V is Y + 1;
    Z == 'Navigate Southwest' -> W is X + 1, V is Y - 1;
    Z == 'You arrived!' -> W is X, V is Y.

showNextVision(W,V):-
       vision(D,W,V), write('Once there you´ll see: '), write(D),
    	nl, write('You can make the next query with: getNextMove(\''), write(D), write('\').');
       vision(D,E,W,V), write('Once there you´ll see: '), write(D), write(' and '), write(E),
       	nl, write('You can make the next query with: getNextMove(\''), write(D), write('\',\''), write(E), write('\').');
       vision(D,E,F,W,V), write('Once there you´ll see: '), write(D), write(', '), write(E), write(', '), write(' and '), write(F),
        nl, write('You can make the next query with: getNextMove(\''), write(D), write('\',\''), write(E), write('\',\''), write(F), write('\').');
	   vision(D,E,F,G,W,V), write('Once there you´ll see: '), write(D), write(', '), write(E), write(', '), write(F), write(' and '), write(G),
        nl, write('You can make the next query with: getNextMove(\''), write(D), write('\',\''), write(E), write('\',\''), write(F), write('\',\''), write(G), write('\').');
	   vision(D,E,F,G,H,W,V), write('Once there you´ll see: '), write(D), write(', '), write(E), write(', '), write(F), write(', '), write(G), write(' and '), write(H),
      	nl, write('You can make the next query with: getNextMove(\''), write(D), write('\',\''), write(E), write('\',\''), write(F), write('\',\''), write(G), write('\',\''), write(H), write('\').');
       vision(D,E,F,G,H,I,W,V), write('Once there you´ll see: '), write(D), write(', '), write(E), write(', '), write(F), write(', '), write(G), write(', '), write(H), write(' and '), write(I),
        nl, write('You can make the next query with: getNextMove(\''), write(D), write('\',\''), write(E), write('\',\''), write(F), write('\',\''), write(G), write('\',\''), write(H), write('\',\''), write(I), write('\').').

getNextMove(A):-
	vision(A, X, Y),
    coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).
  
getNextMove(A, B):-
	vision(A,B, X, Y),
  	coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).
  
getNextMove(A, B, C) :-
	vision(A,B,C, X, Y),
  	coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).
  
getNextMove(A, B, C, D):-
	vision(A,B,C,D, X, Y),
  	coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).
  
getNextMove(A, B, C, D, E):-
	vision(A, B, C, D, E, X, Y),
  	coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).
  
getNextMove(A, B, C, D, E, F):-
	vision(A,B,C,D,E,F, X, Y),
  	coordinate(X,Y,Z),
    calculateNewCoordinate(X,Y,Z,W,V),
  	write(Z), nl,
    showNextVision(W,V).

