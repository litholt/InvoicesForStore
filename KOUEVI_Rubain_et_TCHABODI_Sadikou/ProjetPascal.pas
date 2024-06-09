PROGRAM PROJET;

TYPE
	PFacture = ^Facture;  //POINTEUR POUR GERER LES FACTURES
	Produit = RECORD      //RECORD POUR GERER LES PRODUITS
    		CodeProduit: INTEGER;
    		Designation: STRING;
    		PrixU: INTEGER;
    		Quantite: INTEGER;
   		END;   
   	Facture = RECORD
    		DateFact: STRING[10];
    		Numero: INTEGER;
    		CodeClient: string;
    		NomClient: STRING;
    		PrenomClient: STRING;
    		ListeProduit: ARRAY [1..1000] OF Produit;
    		suivant: PFacture;
   		End;
   	Fact = RECORD     //ENREGISTREMENT POUR GERER LE FILE OF
    	D,M: STRING[10];
    	N,W: INTEGER;
    	C: string;
    	Nc: STRING;
    	P: STRING;
    	nb:INTEGER;
    	L: ARRAY [1..1000] OF Produit;
   	END;
   
 VAR                   //DECLARATION DES VARIABLES GLOBALES
   P,Liste : PFacture;
   f : FILE OF Fact;      //f FILE OF QUI ENREGISTRE LES SAISIES EN MEMOIRE
   fi : FILE OF produit;    //fi FILE OF QUI ENREGISTRE LES SAISIES DES PRODUITS
   fich : TEXT;
   periode : Fact;
   article : produit;
   i,T,c,n,ct,W,donne,find,QUITTER : INTEGER;
   y,O,Q : CHAR;
   choix ,x: INTEGER;
   d,No,Pre,M: STRING;
   dt : STRING[10];
   H ,tt: REAL;       //POUR CALCULER LES TOTAUX
  
 PROCEDURE VERIFICATION_NUMERO_DE_FACTURE;       //PROCEDURE QUI VERIFIE SI  LE NUMERO DE FACTURE EST UNIQUE 
 	BEGIN
 	  REPEAT 
 	    {$I-}
 	    repeat
 	  	REPEAT
 			WRITE(' -NUMERO DE FACTURE (Doit etre inexistante): ');      
  			READLN(donne);
  			x:=IOresult;
  			IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     	UNTIL (x=0);
     	until donne>0;
     	{$I+}
     	
 		ASSIGN(f,'Wfact.txt');
     	RESET(f);                //OUVERTURE ET VERIFICATION
     	SEEK(f,0);
      		WHILE NOT(Eof(f)) DO    
	    	BEGIN 
	    		READ(f,periode);
          			IF periode.N=donne THEN
          		  		BEGIN 
          				ct:=donne;
          		  		END;
                	END;
      	CLOSE(f);
      UNTIL donne<>ct;
    END; 
    
 PROCEDURE VERIFICATION_EXISTENCE_DU_PRODUIT;   //PROCEDURE VERIFIANT L'EXISTNCE D'UN PRODUIT
 	BEGIN
  		ASSIGN(fi,'Yarticle.txt');    //Yarticle FICHIER LIE A f CONTENANT LES ENREGISTREMENTS DES ANCIENNES FACTURES
    	RESET(fi);
   		SEEK(fi,0);
  		WHILE NOT(Eof(fi)) DO    
			BEGIN 
				read(fi,article);
     				IF article.Designation=d THEN
   			          	BEGIN 
        		       	  find:=1;
        		      	END;
       	 	END;
     	CLOSE(fi);
    END;
  
 PROCEDURE STOCKAGE_PHYSIQUE_DE_PRODUITS;     //PROCEDURE ENREGISTRANT DANS UN FICHIER PHYSIQUE LA LISTE DES PRODUITS
 	BEGIN
 		ASSIGN(fich,'LA_LISTE_DES_PRODUITS_DU_MAGAZIN.txt');  //LA_LISTE_DES_PRODUITS_DU_MAGAZIN.txt FICHIER PHYSIQUE DES PRODUITS DU MAGAZIN
		APPEND(fich);
		WRITELN(fich,'Designation : ',P^.ListeProduit[i].Designation);
		WRITELN(fich,'CodeProduit : ',P^.ListeProduit[i].CodeProduit);
		WRITELN(fich,'PrixU : ',P^.ListeProduit[i].PrixU);
	    WRITELN(fich);
 		CLOSE(fich);
 	END;
   
 PROCEDURE AFFICHAGE_ECRAN_DE_FACTURE;   //PROCEDURE AFFICHANT UNE FACTURE SAISIE
 	BEGIN
 		IF ((O='O') OR (O='o')) THEN
     	 	 BEGIN
     	 		p:=Liste;
     	 		WRITELN('');
   				WRITELN('  +* + + + + + + + + + + + + + *+***FACTURE***+* + + + + + + + + + + + + + *+');
    			WRITELN('  + XXX S.A.R.L                                    Facture N ',P^.Numero);
    			WRITELN('  + 100,Rue LA FONTAINE VIERGE                                              +');
    			WRITELN('  + BP:2103 Rubain_Sadikou                                                  +');
    			WRITELN('  + Tel : 00228 93703387                                                    +');
      			WRITELN('  +                                                Date:',P^.DateFact,'            +');
       			WRITELN('  +   CLIENT:                                                               +');
      			WRITELN('  +     Codeclient : ',P^.CodeClient);
       			WRITELN('  +     Nom        : ',P^.NomClient);
       			WRITELN('  +     Prenom     : ',P^.PrenomClient);
       			WRITELN('  +                                                                         +');
       			H:=0;
       			WRITELN('  +  .CODE ARTICLE.     .DESIGNATION.         .PRIX UNITAIRE.    .QUANTITE. +');
         		c:=1; 
         			FOR c:=1 TO n DO
         				BEGIN						
       						WRITE('  +   ',P^.ListeProduit[c].CodeProduit,'                    ');
       						WRITE(P^.ListeProduit[c].Designation,'                   ');
       						WRITE(P^.ListeProduit[c].PrixU,'           ');
       						WRITELN(P^.ListeProduit[c].Quantite);
       						H:=H+(P^.ListeProduit[c].PrixU*P^.ListeProduit[c].Quantite);
         				END;
         		WRITELN('  +                                                                         +');
         		WRITELN('  +                         Total Hors Taxe : ',H:2:2,' Fcfa');
       			WRITELN('  +                         TVA 12%         : ',H*0.12:2:2,' Fcfa');
       			WRITELN('  +                         Total TTC       : ',H+(H*0.12):2:2,' Fcfa'); 
       			WRITELN('  *    Merci pour votre Fidelite                                            +');
       			WRITELN('  +* + + + + + + + + + + + + + *+*************+* + + + + + + + + + + + + + *+');
       			WRITELN('');    
       			WRITELN('');					
     	 	 END;
 	END;
 	
 PROCEDURE AFFICHAGE_A_UNE_DATE_DONNEE;   //PROCEDURE AFFICHANT UNE FACTURE A UNE DATE DONNEE
 	BEGIN
 		T:=T+1;	       		        
	    				WRITELN(''); 
	    				WRITELN('  +* + + + + + + + + + + + + + *+***FACTURE***+* + + + + + + + + + + + + + *+');			 
    					WRITELN('  * XXX S.A.R.L                                      Facture N ',periode.N);
        				WRITELN('  + 100,Rue LA FONTAINE VIERGE                                              +');
    					WRITELN('  + BP:2103 Rubain_Sadikou                                                  +');
    					WRITELN('  + Tel : 00228 93703387                                                    +');
      					WRITELN('  +                                                   Date:',periode.D,'         +');
       					WRITELN('  +   CLIENT:                                                               +');
      					WRITELN('  +     Codeclient : ',periode.C);
       					WRITELN('  +     Nom        : ',periode.Nc);
       					WRITELN('  +     Prenom     : ',periode.P);
       					WRITELN('  +                                                                         +');
       					H:=0;
       					WRITELN('  +  .CODE ARTICLE.     .DESIGNATION.         .PRIX UNITAIRE.    .QUANTITE. +'); 
         					FOR i:=1 TO periode.nb DO
         						BEGIN						
       								WRITE('  *  ',periode.L[i].CodeProduit,'                    ');
       								WRITE(periode.L[i].Designation,'                    ');
       								WRITE(periode.L[i].PrixU,'           ');
       								WRITELN(periode.L[i].Quantite);
       								H:=H+(periode.L[i].PrixU*periode.L[i].Quantite);
         						END;
        				WRITELN('  +                                                                         +');
        				WRITELN('  +                         Total Hors Taxe : ',H:2:2,' Fcfa');
       					WRITELN('  +                         TVA 12%         : ',H*0.12:2:2,' Fcfa');
       					WRITELN('  +                         Total TTC       : ',H+(H*0.12):2:2,' Fcfa'); 
       					WRITELN('  *    Merci pour votre Fidelite                                            +');
       					WRITELN('  +* + + + + + + + + + + + + + *+*************+* + + + + + + + + + + + + + *+');
       					WRITELN('');
       					tt:=tt+periode.L[i].PrixU*periode.L[i].Quantite+(periode.L[i].PrixU*periode.L[i].Quantite*0.12);
 END;	
 	
 PROCEDURE SAISIR_FACTURES;    //PROCEDURE QUI GERE LA SAISIE DES FACTURES
 	BEGIN  
  
 		 REPEAT
 		   
  	 		VERIFICATION_NUMERO_DE_FACTURE;        //PROCEDURE
  	 		
     		NEW(P);
     		ASSIGN(f,'Wfact.txt');       //Wfact FILE OF ,GERANT LES ENREGISTREMENT EN MEMOIRE DES FACTURES
     		RESET(f);    
     		
     		P^.Numero:=donne;
     		periode.N:=P^.Numero;
			{$I-}
			
     		WRITE(' -DATE(Format JJ/MM/AA): ');
     		READLN(P^.DateFact);             
     		periode.D:=P^.DateFact;          //LES VALEURS RECUES PAR LE POINTEUR SONT RECUPEREES ET GARDE EN MEMOIRE
     

     		REPEAT
     			WRITE(' -CODE CLIENT     : ');
     			READLN(P^.CodeClient);
     			x:=IOresult;
     		    IF(x<>0) THEN WRITELN(' vous devez saisir un entier!');
     		UNTIL (x=0);
     		periode.C:=P^.CodeClient;
     			
     		WRITE(' -NOM CLIENT      : ');
     		READLN(P^.NomClient);
     		periode.Nc:=P^.NomClient;
          
     		WRITE(' -PRENOM CLIENT   : ');
     		READLN(P^.PrenomClient);
     		periode.P:=P^.PrenomClient;
     		
     		WRITELN(' -A l''ACHAT');
     		  repeat
     		  REPEAT
     			WRITE('   Nombre de produit : ');
     			READLN(n); 
     			x:=IOresult;
     		    IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     		  UNTIL (x=0);
     		  until n>0; 
     		  {$I+}		
     		  periode.nb:=n;
     		
     		  FOR i:=1 TO n DO
          	  	BEGIN	
          		  	find:=0;
          		  	WRITE('		.Designation de l''article ',i,' : ');
          		   	READLN(d);

     				VERIFICATION_EXISTENCE_DU_PRODUIT;	    //PROCEDURE        
          		   	
          		    P^.ListeProduit[i].Designation := d;
          		    periode.L[i].Designation := P^.ListeProduit[i].Designation;
					{$I-}
					repeat
					repeat 
          		    	WRITE('		.Son Code          : ');
          		    	READLN(P^.ListeProduit[i].CodeProduit);
          		    	x:=IOresult;
          		    	IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     				UNTIL (x=0);
     				until P^.ListeProduit[i].CodeProduit>0;
          		    periode.L[i].CodeProduit := P^.ListeProduit[i].CodeProduit;
          		
          		    repeat
          		    repeat
          		    	WRITE('		.Son Prix Unitaire : ');
          		    	READLN(P^.ListeProduit[i].PrixU);
          		    	x:=IOresult;
     		    		IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     				UNTIL (x=0);
     				until P^.ListeProduit[i].PrixU>0;
     				periode.L[i].PrixU := P^.ListeProduit[i].PrixU;
          		
          		    repeat
          		    repeat
          		    	WRITE('		.Quantite Achete   : ');
          		    	READLN(P^.ListeProduit[i].Quantite);
          		    	x:=IOresult;
          		    	IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     				UNTIL (x=0);
     				until P^.ListeProduit[i].Quantite>0;
					periode.L[i].Quantite:=P^.ListeProduit[i].Quantite;
	{$I+}
					
                    WRITELN(''); 
                    IF find=0 THEN
                 		BEGIN
                 		    ASSIGN(fi,'Yarticle.txt');  //ENREGISTREMENT DES PRODUITS EN MEMOIRE
          		    		RESET(fi);  
          		    		article.Designation := P^.ListeProduit[i].Designation;
                   		    article.CodeProduit := P^.ListeProduit[i].CodeProduit;
                   		    article.PrixU := P^.ListeProduit[i].PrixU;
                   		    article.Quantite := P^.ListeProduit[i].Quantite;
                   		    
                   		    SEEK(fi, FILESIZE(fi));
                    		WRITE(fi, article);  
                    		CLOSE(fi);
                    		
                   		    STOCKAGE_PHYSIQUE_DE_PRODUITS;  //PROCEDURE     
				  		END;
                END;
                   
 		   SEEK(f, FILESIZE(f)); 
   	 	   WRITE(f, periode);
   	 	   CLOSE(f);
   	 		
           P^.Suivant := Liste;
     	   Liste:=P;
     	 		
  	 	   WRITE('AFFICHIER CETTE FACTURE ?[O/N] : ');
   	 	   READLN(O);
   	 	   AFFICHAGE_ECRAN_DE_FACTURE;	 	 
     	   WRITE(' CONTINUER AVEC UNE NOUVELLE FACTURE ?[O/N]  : ');
           READLN(y);
        UNTIL ((y='N') OR (y='n')) ;   
    END;
 
 PROCEDURE LISTE_FACTURES_A_UNE_DATE;   //PROCEDURE GERANT L'AFFICHAGE A UNE DATE DONNEE
 	BEGIN
       REPEAT
      	  WRITE('  Date (Format JJ/MM/AA) : ');
          READLN(dt); 
     	  T:=0;
     	  ASSIGN(f,'Wfact.txt');
       	  RESET(f);
          SEEK(f, 0);   
	   	  WHILE NOT(Eof(f)) DO    
	    	BEGIN 
	    	  READ(f, periode);         	
	    	  IF periode.D = dt THEN
	      		    BEGIN 
 						AFFICHAGE_A_UNE_DATE_DONNEE;  //PROCEDURE
 	   
	      		    END;
	      	END;
	      IF (T=0) THEN 
	      	BEGIN
	      		WRITELN('');
	      		WRITELN('   Il n''Existe Pas De Facture Datant Du : ',dt);
	      		WRITELN('');
	      	END;
	     CLOSE(f);
   		 WRITE('   Recommencer Avec Une Nouvelle Date?[O/N] : ');
   		 READLN(Q);
   	  UNTIL ((Q='N') OR (Q='n'));	 
    
   END;
   
 PROCEDURE AFFICH_P;
	
	BEGIN
		  ASSIGN(fi,'Yarticle.txt');
       	  RESET(fi);   
	   	  WHILE NOT(Eof(fi)) DO    
	    	BEGIN 
	    	  READ(fi,article);
	    	  WRITELN('Designation  : ',article.Designation); 
	    	  WRITELN('CodeProduit  : ',article.CodeProduit);
	    	  WRITELN('PrixUnitaire : ',article.PrixU);	  
	    	  writeln('');  	  	
			END;
		  close(fi);
    end;
 PROCEDURE AFF;
   BEGIN
 
       REPEAT
       	  tt:=0;
      	  WRITE('  Nom Du Client : ');
          READLN(No);
          WRITE('  Prenom Du Client: ');
          READLN(Pre); 
     	  W:=0;
     	  ASSIGN(f,'Wfact.txt');
       	  RESET(f);
          SEEK(f, 0);   
	   	  WHILE NOT(Eof(f)) DO    
	    	BEGIN 
	    	  READ(f, periode);         	
	    	  IF ((periode.Nc =No) AND (periode.P=Pre)) THEN
	      		    BEGIN
	       		       W:=1;
 						AFFICHAGE_A_UNE_DATE_DONNEE;  //PROCEDURE
 	   
	      		    END;
	        END;
	      	  IF W=1 THEN  writeln('LE MONTANT DES ACHATS DE ',No,' ',Pre,' S''ELEVE A ',tt:2:2,' Fcfa')
	      	
	      ELSE IF (W=0) THEN 
	      	BEGIN
	      		WRITELN('');
	      		WRITELN('   ',No,' ',Pre,' N''existe pas dans la base de donnee');
	      		WRITELN('');
	      	END;
	     CLOSE(f);
   		 WRITE('   SE RENSEIGNER SUR UN AUTRE INDIVIDU ?[O/N] : ');
   		 READLN(M);
   	  UNTIL ((M='N') OR (M='n'));
   END;   

 BEGIN
 							//DEBUT DU PROGAMME PRINCIPAL
 	WRITELN('+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +');
 	WRITELN('+                    PROGAMME DE GESTION DU MAGAZIN                   +');
 	WRITELN('+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +');
   
   	  REPEAT 
        WRITELN('');
        writeln('                                 +MENU+                               ');
        WRITELN(' 1-POUR------------*SAISIR ET/OU AFFICHAGE D''UNE FACTURE*-----------+');
        WRITELN(' 2-POUR----------*AFFICHER LES FACTURES D''UNE DATE DONNEE*----------+');
        writeln(' 3-POUR--------------------------PRODUITS---------------------------+');
        WRITELN(' 4-POUR----------*AFFICHER LE(S) FACTURE(S) D''UN CLIENTS*----------+');
        WRITELN(' 0-POUR---------------------------QUITTER---------------------------+');
        	REPEAT
            	WRITELN('');
            	{$I-}
            	repeat
          			WRITE('  .VOTRE CHOIX PAR RAPPORT AU MENU : ');
        			READLN(choix);
        			x:=IOresult;
        			IF(x<>0) THEN WRITELN('  vous devez saisir un entier!  ');
     			UNTIL (x=0);
     			{$I+}
        		WRITELN('');
        			CASE choix OF
           				1 : SAISIR_FACTURES;        //PROCEDURE
           				2 : LISTE_FACTURES_A_UNE_DATE;        //PROCEDURE
           				3 : AFFICH_P;
           				4 : AFF;
           				0 : QUITTER:=1;
        			  ELSE WRITELN('	SAISIE INCORRECTE.');
             	    END;
          	UNTIL (choix=1) OR (choix=2) OR (choix=0) or (choix=3) or (choix=4);
    UNTIL QUITTER=1;
 END.
