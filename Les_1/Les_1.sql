/*
������ � ���� �� ������ �� �������� (����� ������� Orders � csv, �������� �����
https://drive.google.com/drive/folders/1C3HqIJcABblKM2tz8vPGiXTFT7MisrML?usp=sharin
g )
2. ����������������, ����� ������ ������ ��������
3. ��������� ���-�� �����, ���-�� ������� � ���-�� ���������� �������������, ���
��������� ������.
4. �� ����� ��������� ������� ���, ������� ���-�� ������� �� ������������, �������
����� , ��� ���������� ��� ���������� ��� �� ����.
5. ����� ���-�� �������������, ��� �������� � ����� ���� � ��������� �������� �
���������.
6. ����� ID ������ ��������� �� ���-�� ������� ������������. */

CREATE DATABASE IF NOT EXISTS db_for_analyt

USE db_for_analyt

CREATE TABLE `orders` (
  `id_o` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `o_date` date DEFAULT NULL)


SELECT * FROM orders_20190822
