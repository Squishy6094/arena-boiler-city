const Collision bob_area_1_collision[] = {
	COL_INIT(),
	COL_VERTEX_INIT(18),
	COL_VERTEX(-400, 100, -1294),
	COL_VERTEX(-400, 100, 2047),
	COL_VERTEX(400, 100, 2047),
	COL_VERTEX(400, 100, -1294),
	COL_VERTEX(400, -100, -1294),
	COL_VERTEX(400, -100, 2047),
	COL_VERTEX(-400, -100, 2047),
	COL_VERTEX(-400, -100, -1294),
	COL_VERTEX(400, -100, -2019),
	COL_VERTEX(400, 513, -2019),
	COL_VERTEX(-400, -100, -2019),
	COL_VERTEX(-400, -100, -2896),
	COL_VERTEX(400, -100, -2896),
	COL_VERTEX(-400, 513, -2019),
	COL_VERTEX(400, 513, -1294),
	COL_VERTEX(-400, 513, -1294),
	COL_VERTEX(-400, 100, -2896),
	COL_VERTEX(400, 100, -2896),
	COL_TRI_INIT(SURFACE_DEFAULT, 32),
	COL_TRI(0, 1, 2),
	COL_TRI(0, 2, 3),
	COL_TRI(4, 3, 2),
	COL_TRI(4, 2, 5),
	COL_TRI(5, 2, 1),
	COL_TRI(5, 1, 6),
	COL_TRI(6, 7, 4),
	COL_TRI(6, 4, 5),
	COL_TRI(3, 4, 8),
	COL_TRI(3, 8, 9),
	COL_TRI(6, 1, 0),
	COL_TRI(6, 0, 7),
	COL_TRI(8, 10, 11),
	COL_TRI(8, 11, 12),
	COL_TRI(7, 0, 13),
	COL_TRI(7, 13, 10),
	COL_TRI(4, 7, 10),
	COL_TRI(4, 10, 8),
	COL_TRI(3, 9, 14),
	COL_TRI(15, 14, 9),
	COL_TRI(15, 9, 13),
	COL_TRI(0, 3, 14),
	COL_TRI(0, 14, 15),
	COL_TRI(13, 0, 15),
	COL_TRI(11, 16, 17),
	COL_TRI(11, 17, 12),
	COL_TRI(9, 8, 12),
	COL_TRI(9, 12, 17),
	COL_TRI(13, 9, 17),
	COL_TRI(13, 17, 16),
	COL_TRI(10, 13, 16),
	COL_TRI(10, 16, 11),
	COL_TRI_STOP(),
	COL_END()
};
