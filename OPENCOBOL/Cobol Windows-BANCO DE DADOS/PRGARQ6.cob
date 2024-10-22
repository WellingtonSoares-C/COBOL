       IDENTIFICATION                            DIVISION.
       PROGRAM-ID. PRGARQ6.
      *=================================================================
      *== PROGRAMADOR : WELLINGTON SOARES CORDEIRO
      *== OBJETIVO    : PROCURA DE UM REGISTRO ARQUIVO CLIENTES.dat
      *== DATA        : 10/07/2024
      *== CONSULTORIA : FOURSYS
      *=================================================================
      *== ALTERACAO   :
      *=================================================================
       ENVIRONMENT                               DIVISION.

       CONFIGURATION                             SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT                              SECTION.
       FILE-CONTROL.
           SELECT CLIENTES ASSIGN
           TO "C:\COBOL\Cobol Windows-BANCO DE DADOS\DADOS\CLIENTES.dat"
             FILE STATUS IS FS-CLIENTES.
      *-----------------------------------------------------------------

       DATA                                      DIVISION.
       FILE                                      SECTION.
       FD CLIENTES.
       01  REG-CLIENTES.
           05 REG-ID         PIC X(04).
           05 REG-NOME       PIC X(20).
           05 REG-TELEFONE   PIC X(11).

       WORKING-STORAGE                           SECTION.
       77  FS-CLIENTES           PIC 9(02).

       77  WRK-PROCURA           PIC 9(04) VALUE ZEROS.

       77  WRK-MSG-FIM           PIC X(30) VALUE
                                       "FIM PROGRAMA".

       77  WRK-MSG-ERRO          PIC X(30) VALUE
                                       "ARQUIVO NAO EXISTE!".

       77  WRK-MSG-VAZIO         PIC X(30) VALUE
                                      "ARQUIVO VAZIO".
       01  WRK-CLIENTES.
           05 WRK-ID         PIC 9(04).
           05 WRK-NOME       PIC X(20).
           05 WRK-TELEFONE   PIC 9(11).
      *-----------------------------------------------------------------
       PROCEDURE                                 DIVISION.
       0001-PRINCIPAL                            SECTION.

           PERFORM 0100-INICIALIZAR.
           PERFORM 0200-PROCESSAR.
           PERFORM 0300-FINALIZAR.
           STOP RUN.


      *-----------------------------------------------------------------
       0100-INICIALIZAR                              SECTION.

           OPEN INPUT CLIENTES.

             IF FS-CLIENTES EQUAL 35
               PERFORM 9000-TRATA-ERRO
             END-IF.

           DISPLAY "DIGITE O ID QUE DESEJA PROCURAR.."
               ACCEPT WRK-PROCURA
           DISPLAY "=================================".

       0100-INICIALIZAR-FIM. EXIT.



      *-----------------------------------------------------------------
       0200-PROCESSAR                            SECTION.

             READ CLIENTES
               IF FS-CLIENTES EQUAL 00
                PERFORM UNTIL FS-CLIENTES NOT EQUAL 00
                  IF REG-ID EQUAL WRK-PROCURA
                     DISPLAY REG-CLIENTES
                     DISPLAY "ID...." REG-ID
                     DISPLAY "NOME.." REG-NOME
                     DISPLAY "FONE.." REG-TELEFONE
                     DISPLAY "STATUS.." FS-CLIENTES
                     DISPLAY"========================================="
                        CLOSE CLIENTES
                        PERFORM 0300-FINALIZAR
                        GOBACK

                 END-IF

                 READ CLIENTES
                END-PERFORM
              ELSE
                  DISPLAY WRK-MSG-VAZIO
              END-IF.

       0200-PROCESSAR-FIM. EXIT.



      *-----------------------------------------------------------------
       0300-FINALIZAR                            SECTION.

             DISPLAY WRK-MSG-FIM.
             CLOSE CLIENTES.

       0300-FINALIZAR-FIM. EXIT.

      *-----------------------------------------------------------------

       9000-TRATA-ERRO                           SECTION.

           DISPLAY WRK-MSG-ERRO.
           GOBACK.

       9000-TRATA-ERRO-FIM. EXIT.
      *-----------------------------------------------------------------