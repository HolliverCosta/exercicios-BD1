INSERT INTO time VALUES ('Paraiba Vôlei', 01 ,'Brasil','Campina Grande');
INSERT INTO time VALUES ('Sada Cruzeiro Vôlei', 02 ,'Brasil','Joao pessoa');
INSERT INTO time VALUES ('Sesi-SP', 03 ,'Brasil','São paulo');
INSERT INTO time VALUES ('Vôlei Taubaté', 04 ,'Brasil','São paulo');
--Jogadores time 1
INSERT INTO jogador VALUES ('Joao', 21 ,171,12345678901, 'Levantador', 01 );
INSERT INTO jogador VALUES ('Pedro', 25 ,177,12345678902, 'Libero', 01 );
INSERT INTO jogador VALUES ('Felipe', 22 ,180,12345678903, 'Pontas', 01 );
INSERT INTO jogador VALUES ('Caio', 27 ,182,12345678904, 'Central', 01 );
INSERT INTO jogador VALUES ('Holliver', 21 ,174,12345678905, 'Oposto', 01 );
INSERT INTO jogador VALUES ('Luiz', 23 ,177,12345678906, 'Levantador', 01 );
INSERT INTO jogador VALUES ('Antonio', 24 ,175,12345678907, 'Reserva', 01 );
--Jogadores time 2
INSERT INTO jogador VALUES ('Daniel', 21 ,171,12345678908, 'Levantador', 02 );
INSERT INTO jogador VALUES ('Andre', 25 ,177,12345678909, 'Libero', 02 );
INSERT INTO jogador VALUES ('Breno', 22 ,180,12345678910, 'Pontas', 02 );
INSERT INTO jogador VALUES ('Danilo', 27 ,182,12345678911, 'Central', 02 );
INSERT INTO jogador VALUES ('Enzo', 21 ,174,12345678912, 'Oposto', 02 );
INSERT INTO jogador VALUES ('Davi', 23 ,177,12345678913, 'Levantador', 02 );
INSERT INTO jogador VALUES ('Benicio', 24 ,175,12345678914, 'Reserva', 02 );
--Jogadores time 3
INSERT INTO jogador VALUES ('Flavio', 21 ,171,12345678915, 'Levantador', 03 );
INSERT INTO jogador VALUES ('Luciano', 25 ,177,12345678916, 'Libero', 03 );
INSERT INTO jogador VALUES ('Lucas', 22 ,180,12345678917, 'Pontas', 03 );
INSERT INTO jogador VALUES ('Leo', 27 ,182,12345678918, 'Central', 03 );
INSERT INTO jogador VALUES ('Djalma', 21 ,174,12345678919, 'Oposto', 03 );
INSERT INTO jogador VALUES ('Razman', 23 ,177,12345678920, 'Levantador', 03 );
INSERT INTO jogador VALUES ('Victor', 24 ,175,12345678921, 'Reserva', 03 );
--Jogadores time 4
INSERT INTO jogador VALUES ('Helder', 21 ,171,12345678922, 'Levantador', 04 );
INSERT INTO jogador VALUES ('Hermani', 25 ,177,12345678923, 'Libero', 04 );
INSERT INTO jogador VALUES ('Helton', 22 ,180,12345678924, 'Pontas', 04 );
INSERT INTO jogador VALUES ('Rai', 27 ,182,12345678925, 'Central', 04 );
INSERT INTO jogador VALUES ('Tao', 21 ,174,12345678926, 'Oposto', 04 );
INSERT INTO jogador VALUES ('Lucas cartaxo', 23 ,177,12345678927, 'Levantador', 04 );
INSERT INTO jogador VALUES ('Arthur', 24 ,175,12345678928, 'Reserva', 04 );

--Jogo time 1 VS time 2 
INSERT INTO jogo VALUES ('Paraiba Vôlei VS Sada Cruzeiro Vôlei', '28-APR-2021',NULL,01,02);
--Jogo time 3 VS time 4 
INSERT INTO jogo VALUES ('Sesi-SP VS Vôlei Taubaté', '28-APR-2021',NULL,03,04);

--Escalacao time 1
INSERT INTO escalação VALUES ('Levantador','12345678901','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Libero' ,'12345678902','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Pontas' ,'12345678903','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Central' ,'12345678904','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Oposto' ,'12345678905'),'Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Levantador' ,'12345678906','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
--Escalacao time 2
INSERT INTO escalação VALUES ('Levantador' ,'12345678908','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Libero' ,'12345678909','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Oposto' ,'12345678910','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Central' ,'12345678911','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Pontas','12345678912','Paraiba Vôlei VS Sada Cruzeiro Vôlei');
INSERT INTO escalação VALUES ('Levantador','12345678913','Paraiba Vôlei VS Sada Cruzeiro Vôlei');

--Escalação time 3
INSERT INTO escalação VALUES ('Levantador' ,'12345678915', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Libero' ,'12345678916', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Pontas' ,'12345678917', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Central' ,'12345678918', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Oposto','12345678919', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Levantador','12345678920', 'Sesi-SP VS Vôlei Taubaté');
--Escalacao time 4
INSERT INTO escalação VALUES ('Levantador' ,'12345678922', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Libero' ,'12345678923', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Pontas' ,'12345678924', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Central' ,'12345678925', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Oposto' ,'12345678926', 'Sesi-SP VS Vôlei Taubaté');
INSERT INTO escalação VALUES ('Levantador','12345678927', 'Sesi-SP VS Vôlei Taubaté');




