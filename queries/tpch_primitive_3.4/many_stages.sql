-- many_stages.sql
---- QUERY: many_stages
-- Description : Query with a large number of shuffle joins
-- Target test case : Run a query with a large number of fragments
--  stressing query startup, connection creation and query teardown
select
/*+ SHUFFLE_HASH(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,R,S,T,U,V,W,X,Y,Z,
z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16,z17,z18,z19,z20,
z21,z22,z23,z24,z25,z26,z27,z28,z29,z30,z31,z32,z33,z34,z35,z36,z37,z38,z39,z40,
z41,z42,z43,z44,z45,z46,z47,z48,z49,z50,z51,z52,z53,z54,z55,z56,z57,z58,z59,z60,
z61,z62,z63,z64,z65,z66,z67,z68,z69,z70,z71,z72,z73,z74,z75,z76,z77,z78,z79,z80,
z81,z82,z83,z84,z85,z86,z87,z88,z89,z90,z91,z92,z93,z94,z95,z96,z97,z98,z99,z100) */
count(*),a.c_nationkey, max(b.c_comment) from   customer A
join  customer B on A.c_custkey = B.c_custkey
join   customer C on c.c_custkey = B.c_custkey
join   customer D on d.c_custkey = B.c_custkey
join   customer E on e.c_custkey = B.c_custkey
join   customer F on f.c_custkey = B.c_custkey
join   customer G on g.c_custkey = B.c_custkey
join   customer H on h.c_custkey = B.c_custkey
join   customer I on i.c_custkey = B.c_custkey
join   customer J on j.c_custkey = B.c_custkey
join   customer K on k.c_custkey = B.c_custkey
join   customer L on l.c_custkey = B.c_custkey
join   customer M on m.c_custkey = B.c_custkey
join   customer N on n.c_custkey = B.c_custkey
join   customer O on o.c_custkey = B.c_custkey
join   customer P on p.c_custkey = B.c_custkey
join   customer R on R.c_custkey = B.c_custkey
join   customer S on S.c_custkey = B.c_custkey
join   customer T on T.c_custkey = B.c_custkey
join   customer U on U.c_custkey = B.c_custkey
join   customer V on V.c_custkey = B.c_custkey
join   customer W on W.c_custkey = B.c_custkey
join   customer X on X.c_custkey = B.c_custkey
join   customer Y on Y.c_custkey = B.c_custkey
join   customer Z on Z.c_custkey = B.c_custkey
join   customer z1  on Z1.c_custkey = B.c_custkey
join   customer z2  on Z2.c_custkey = B.c_custkey
join   customer z3  on Z3.c_custkey = B.c_custkey
join   customer z4  on Z4.c_custkey = B.c_custkey
join   customer z5  on Z5.c_custkey = B.c_custkey
join   customer z6  on Z6.c_custkey = B.c_custkey
join   customer z7  on Z7.c_custkey = B.c_custkey
join   customer z8  on Z8.c_custkey = B.c_custkey
join   customer z9  on Z9.c_custkey = B.c_custkey
join   customer z10  on Z10.c_custkey = B.c_custkey
join   customer z11  on Z11.c_custkey = B.c_custkey
join   customer z12  on Z12.c_custkey = B.c_custkey
join   customer z13  on Z13.c_custkey = B.c_custkey
join   customer z14  on Z14.c_custkey = B.c_custkey
join   customer z15  on Z15.c_custkey = B.c_custkey
join   customer z16  on Z16.c_custkey = B.c_custkey
join   customer z17  on Z17.c_custkey = B.c_custkey
join   customer z18  on Z18.c_custkey = B.c_custkey
join   customer z19  on Z19.c_custkey = B.c_custkey
join   customer z20  on Z20.c_custkey = B.c_custkey
join   customer z21  on Z21.c_custkey = B.c_custkey
join   customer z22  on Z22.c_custkey = B.c_custkey
join   customer z23  on Z23.c_custkey = B.c_custkey
join   customer z24  on Z24.c_custkey = B.c_custkey
join   customer z25  on Z25.c_custkey = B.c_custkey
join   customer z26  on Z26.c_custkey = B.c_custkey
join   customer z27  on Z27.c_custkey = B.c_custkey
join   customer z28  on Z28.c_custkey = B.c_custkey
join   customer z29  on Z29.c_custkey = B.c_custkey
join   customer z30  on Z30.c_custkey = B.c_custkey
join   customer z31  on Z31.c_custkey = B.c_custkey
join   customer z32  on Z32.c_custkey = B.c_custkey
join   customer z33  on Z33.c_custkey = B.c_custkey
join   customer z34  on Z34.c_custkey = B.c_custkey
join   customer z35  on Z35.c_custkey = B.c_custkey
join   customer z36  on Z36.c_custkey = B.c_custkey
join   customer z37  on Z37.c_custkey = B.c_custkey
join   customer z38  on Z38.c_custkey = B.c_custkey
join   customer z39  on Z39.c_custkey = B.c_custkey
join   customer z40  on Z40.c_custkey = B.c_custkey
join   customer z41  on Z41.c_custkey = B.c_custkey
join   customer z42  on Z42.c_custkey = B.c_custkey
join   customer z43  on Z43.c_custkey = B.c_custkey
join   customer z44  on z44.c_custkey = B.c_custkey
join   customer z45  on z45.c_custkey = B.c_custkey
join   customer z46  on z46.c_custkey = B.c_custkey
join   customer z47  on z47.c_custkey = B.c_custkey
join   customer z48  on z48.c_custkey = B.c_custkey
join   customer z49  on z49.c_custkey = B.c_custkey
join   customer z50  on z50.c_custkey = B.c_custkey
join   customer z51  on z51.c_custkey = B.c_custkey
join   customer z52  on z52.c_custkey = B.c_custkey
join   customer z53  on z53.c_custkey = B.c_custkey
join   customer z54  on z54.c_custkey = B.c_custkey
join   customer z55  on z55.c_custkey = B.c_custkey
join   customer z56  on z56.c_custkey = B.c_custkey
join   customer z57  on z57.c_custkey = B.c_custkey
join   customer z58  on z58.c_custkey = B.c_custkey
join   customer z59  on z59.c_custkey = B.c_custkey
join   customer z60  on z60.c_custkey = B.c_custkey
join   customer z61  on z61.c_custkey = B.c_custkey
join   customer z62  on z62.c_custkey = B.c_custkey
join   customer z63  on z63.c_custkey = B.c_custkey
join   customer z64  on z64.c_custkey = B.c_custkey
join   customer z65  on z65.c_custkey = B.c_custkey
join   customer z66  on z66.c_custkey = B.c_custkey
join   customer z67  on z67.c_custkey = B.c_custkey
join   customer z68  on z68.c_custkey = B.c_custkey
join   customer z69  on z69.c_custkey = B.c_custkey
join   customer z70  on z70.c_custkey = B.c_custkey
join   customer z71  on z71.c_custkey = B.c_custkey
join   customer z72  on z72.c_custkey = B.c_custkey
join   customer z73  on z73.c_custkey = B.c_custkey
join   customer z74  on z74.c_custkey = B.c_custkey
join   customer z75  on z75.c_custkey = B.c_custkey
join   customer z76  on z76.c_custkey = B.c_custkey
join   customer z77  on z77.c_custkey = B.c_custkey
join   customer z78  on z78.c_custkey = B.c_custkey
join   customer z79  on z79.c_custkey = B.c_custkey
join   customer z80  on z80.c_custkey = B.c_custkey
join   customer z81  on z81.c_custkey = B.c_custkey
join   customer z82  on z82.c_custkey = B.c_custkey
join   customer z83  on z83.c_custkey = B.c_custkey
join   customer z84  on z84.c_custkey = B.c_custkey
join   customer z85  on z85.c_custkey = B.c_custkey
join   customer z86  on z86.c_custkey = B.c_custkey
join   customer z87  on z87.c_custkey = B.c_custkey
join   customer z88  on z88.c_custkey = B.c_custkey
join   customer z89  on z89.c_custkey = B.c_custkey
join   customer z90  on z90.c_custkey = B.c_custkey
join   customer z91  on z91.c_custkey = B.c_custkey
join   customer z92  on z92.c_custkey = B.c_custkey
join   customer z93  on z93.c_custkey = B.c_custkey
join   customer z94  on z94.c_custkey = B.c_custkey
join   customer z95  on z95.c_custkey = B.c_custkey
join   customer z96  on z96.c_custkey = B.c_custkey
join   customer z97  on z97.c_custkey = B.c_custkey
join   customer z98  on z98.c_custkey = B.c_custkey
join   customer z99  on z99.c_custkey = B.c_custkey
join   customer z100  on z100.c_custkey = B.c_custkey and b.c_custkey < 10000
AND A.c_custkey > 1
AND c.c_custkey > 2
AND d.c_custkey > 3
AND e.c_custkey > 4
AND f.c_custkey > 5
AND g.c_custkey > 6
AND h.c_custkey > 7
AND i.c_custkey > 8
AND j.c_custkey > 9
AND k.c_custkey > 10
AND l.c_custkey > 11
AND m.c_custkey > 12
AND n.c_custkey > 13
AND o.c_custkey > 14
AND p.c_custkey > 15
AND R.c_custkey > 16
AND S.c_custkey > 17
AND T.c_custkey > 18
AND U.c_custkey > 19
AND V.c_custkey > 20
AND W.c_custkey > 21
AND X.c_custkey > 22
AND Y.c_custkey > 23
AND Z.c_custkey > 24
AND Z1.c_custkey > 25
AND Z2.c_custkey > 26
AND Z3.c_custkey > 27
AND Z4.c_custkey > 28
AND Z5.c_custkey > 29
AND Z6.c_custkey > 30
AND Z7.c_custkey > 31
AND Z8.c_custkey > 32
AND Z9.c_custkey > 33
AND Z10.c_custkey > 34
AND Z11.c_custkey > 35
AND Z12.c_custkey > 36
AND Z13.c_custkey > 37
AND Z14.c_custkey > 38
AND Z15.c_custkey > 39
AND Z16.c_custkey > 40
AND Z17.c_custkey > 41
AND Z18.c_custkey > 42
AND Z19.c_custkey > 43
AND Z20.c_custkey > 44
AND Z21.c_custkey > 45
AND Z22.c_custkey > 46
AND Z23.c_custkey > 47
AND Z24.c_custkey > 48
AND Z25.c_custkey > 49
AND Z26.c_custkey > 50
AND Z27.c_custkey > 51
AND Z28.c_custkey > 52
AND Z29.c_custkey > 53
AND Z30.c_custkey > 54
AND Z31.c_custkey > 55
AND Z32.c_custkey > 56
AND Z33.c_custkey > 57
AND Z34.c_custkey > 58
AND Z35.c_custkey > 59
AND Z36.c_custkey > 60
AND Z37.c_custkey > 61
AND Z38.c_custkey > 62
AND Z39.c_custkey > 63
AND Z40.c_custkey > 64
AND Z41.c_custkey > 65
AND Z42.c_custkey > 66
AND Z43.c_custkey > 67
AND z44.c_custkey > 68
AND z45.c_custkey > 69
AND z46.c_custkey > 70
AND z47.c_custkey > 71
AND z48.c_custkey > 72
AND z49.c_custkey > 73
AND z50.c_custkey > 74
AND z51.c_custkey > 75
AND z52.c_custkey > 76
AND z53.c_custkey > 77
AND z54.c_custkey > 78
AND z55.c_custkey > 79
AND z56.c_custkey > 80
AND z57.c_custkey > 81
AND z58.c_custkey > 82
AND z59.c_custkey > 83
AND z60.c_custkey > 84
AND z61.c_custkey > 85
AND z62.c_custkey > 86
AND z63.c_custkey > 87
AND z64.c_custkey > 88
AND z65.c_custkey > 89
AND z66.c_custkey > 90
AND z67.c_custkey > 91
AND z68.c_custkey > 92
AND z69.c_custkey > 93
AND z70.c_custkey > 94
AND z71.c_custkey > 95
AND z72.c_custkey > 96
AND z73.c_custkey > 97
AND z74.c_custkey > 98
AND z75.c_custkey > 99
AND z76.c_custkey > 100
AND z77.c_custkey > 101
AND z78.c_custkey > 102
AND z79.c_custkey > 103
AND z80.c_custkey > 104
AND z81.c_custkey > 105
AND z82.c_custkey > 106
AND z83.c_custkey > 107
AND z84.c_custkey > 108
AND z85.c_custkey > 109
AND z86.c_custkey > 110
AND z87.c_custkey > 111
AND z88.c_custkey > 112
AND z89.c_custkey > 113
AND z90.c_custkey > 114
AND z91.c_custkey > 115
AND z92.c_custkey > 116
AND z93.c_custkey > 117
AND z94.c_custkey > 118
AND z95.c_custkey > 119
AND z96.c_custkey > 120
AND z97.c_custkey > 121
AND z98.c_custkey > 122
AND z99.c_custkey > 123
GROUP BY a.c_nationkey
