/* Adventure4+ - copyleft @ M.L.Arnautov 1991 */
#include "advkern.h"
int d34() { if (t7(t11(670),16)) { z5(700,670); if (e0[700]>1) { if (m1(64))
{ l12(0,64,1); } else { i7(76,1606,670); }}} } int w24() { if (e0[697]==1)
{ if (g10(114,4) || g10(111,4) || q8(113,-1)) { s4('s',t11(697),5); i7(76,1023,113);
} i7(76,818,113); } i7(64,915,0); } int r26() { if (e0[697]==1) { if (g10(114,3)
|| g10(111,3) || t7(t11(671),9)) { s4('s',t11(697),5); i7(76,1023,669);
} i7(76,818,669); } i7(64,915,0); } int b26() { l12(0,699,1); if (g10(99,1)
|| t7(t11(671),3)) { l12(0,699,0); } else { if (g10(95,3)) { l12(0,699,0);
}} } int b27() { s9(101,485); if (j0[7]==155) { s4('s',155,8); } } int a25()
{ if (e0[759]<135) { i7(0,868,0); } else { i7(2,699,0); } e0[699] = d2(150);
e0[759] += e0[700]; e0[759] += e0[699]; if (e0[759]>1500) { l12(0,759,1500);
} longjmp(n0,1); } int p34() { e0[715] += 1; if (j0[110]==484 && e0[w9]!=412)
{ s9(110,412); s4('c',110,4); } } int a26() { l12(0,686,0); if (e0[715]<1)
{ return 0; } l12(1,702,760); e0[702] *= 100; e0[702] /= e0[715]; e0[702]
*= e0[134]; if (d2(100)<e0[702]) { e0[701] = d2(e0[760]); e0[701] += 1;
*v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1) { if (t7(t11(675),3) &&
j0[e0[675]]==435) { e0[701] -= 1; if (e0[701]==0) { l12(1,686,675); return
0; }}}} } int r27() { *v7(703)= -1; e0[703]=r0-1; while (++e0[703]<=n1)
{ if (e0[686]==0) { a26(); } if (!(e0[686]==0)) { s9(e0[686],e0[671]); e0[760]
-= 1; b26(); if (e0[699]==0) { i7(2,686,0); } l12(0,686,0); } e0[134] -=
1; e0[715] -= 1; if (e0[134]==0) { s9(134,484); return 0; } e0[704] -= 1;
if (e0[704]==0) { return 0; }} } int e24() { e0[699] = d2(5); if (e0[699]==0)
{ f3(676,168); } else { if (e0[699]==1) { f3(676,192); } else { if (e0[699]==2)
{ f3(676,151); } else { if (e0[699]==3) { f3(676,212); } else { f3(676,319);
}}}} i7(0,1230,0); l12(0,701,0); *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1)
{ if (q8(t11(e0[675]),-1) && e0[675]!=78 && t7(t11(675),3)) { i7(0,1232,0);
s9(e0[675],e0[676]); l12(0,701,1); }} if (e0[701]==0) { i7(0,1231,0); }
p9(e0[676],-2); } int j36() { *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1)
{ if (q8(t11(e0[675]),1027)) { s9(e0[675],e0[676]); }} } int e25() { *v7(675)=
-1; e0[675]=r0-1; while (++e0[675]<=n1) { if (m5(t11(e0[675]),1039)) { i7(64,1266,0);
}} } int q36() { if (t7(t11(670),15)) { s9(e0[670],w9); i7(12,1489,669);
i7(76,1490,670); } f3(677,1228); if (d2(100)<10 && j0[78]==393) { f3(677,1229);
s9(78,419); s9(79,485); } i7(12,1544,670); if (t7(t11(670),11)) { i7(11,677,1);
} else { i7(11,677,0); } s9(e0[670],419); longjmp(n0,1); } int l32() { if
(e0[733]==11) { l12(0,699,0); return 0; } l12(1,699,733); if (e0[699]==e0[734])
{ if (d2(100)<10) { l12(0,701,11); e0[701] -= e0[699]; e0[700] = d2(e0[701]);
e0[699] += e0[700]; } else { if (d2(100)<80) { f3(699,0); return 0; }} }
else { l12(1,734,699); } } int h23() { i7(0,1297,0); i7(0,776,0); l12(1,676,671);
e0[701] = d2(3-1+1)+1; if (d2(100)<50) { e0[676] += e0[701]; } else { e0[699]
-= e0[701]; } if (t7(t11(676),3) || t7(t11(676),7) || t7(t11(676),5)) {
l12(1,676,682); } s9(85,e0[676]); if (g10(85,-1)) { s9(85,205); } } int
y20() { if (d2(100)<e0[701]) { i7(0,1520,0); return 0; } if (d2(100)<e0[700])
{ i7(0,1299,0); return 0; } b26(); if (e0[699]==0) { i7(0,1298,0); } else
{ if (g10(87,-1)) { i7(0,1301,0); l12(0,733,4); s9(87,485); l12(0,86,1);
if (e0[115]==2) { l12(0,115,0); } } else { if (g10(134,-1)) { i7(0,1301,0);
l12(1,704,134); r27(); } else { if (g10(20,0)) { i7(0,1467,0); s9(85,485);
} else { i7(0,1300,0); }}} t10(682,85); s9(85,e0[671]); } } int z24() {
l12(1,702,670); if (e0[697]==1 || (513<=e0[669] && e0[669]<=522)) { l12(1,702,669);
} if (e0[701]==0) { s4('s',t11(671),8); p9(e0[678],-1); } else { if (e0[701]==e0[702])
{ p9(e0[678],-2); } p9(e0[679],-2); } } int j37() { if (t7(t11(671),7))
{ f3(699,1695); l12(0,700,200); a25(); } e0[759] = d2(750-600+1)+600; s9(81,485);
s4('s',t11(710),10); if (t7(64,4)) { i7(64,1360,0); } i7(0,1271,0); if (y10(1272))
{ s9(82,e0[671]); i7(64,1276,0); } i7(64,1273,0); } int x28() { l12(0,701,1);
b26(); if (e0[699]==1) { return 0; } l12(0,701,0); if (t7(t11(697),7) ||
e0[717]>0 || t7(t11(671),7) || t7(t11(671),5) || t7(t11(671),11) || t7(19,13)
|| g10(134,-1) || g10(20,-1) || g10(22,-1) || g10(7,-1) || g10(32,-1) ||
e0[714]>0) { l12(0,701,1); } } int i41() { e0[756] -= 1; if (e0[756]<1 &&
d2(100)<25) { x28(); if (e0[701]==1) { return 0; } l12(0,755,-1); if (!(t7(t11(755),0)
|| d2(100)<75 || j0[81]==485 || t7(64,4))) { l12(0,755,0); s4('s',t11(755),0);
} if (e0[755]==-1) { if (!(t7(t11(755),1) || d2(100)<75 || t7(385,4))) {
l12(0,755,1); s4('s',t11(755),1); }} if (e0[755]==-1) { if (!(t7(t11(755),9)
|| d2(100)<75 || t7(119,4) || !(t7(116,4)))) { l12(0,755,9); s4('s',t11(755),9);
}} if (e0[755]==-1) { if (!(t7(t11(755),2) || d2(100)<75 || t7(253,4) ||
!(t7(250,4)))) { l12(0,755,2); s4('s',t11(755),2); }} if (e0[755]==-1) {
if (!(t7(t11(755),3) || d2(100)<75 || !(t7(259,4)) || t7(27,13))) { l12(0,755,3);
s4('s',t11(755),3); }} if (e0[755]==-1) { if (!(t7(t11(755),4) || d2(100)<75
|| t7(253,4))) { l12(0,755,4); s4('s',t11(755),4); }} if (e0[755]==-1) {
if (!(t7(t11(755),6) || d2(100)<75 || j0[95]==140 || !(t7(95,4)))) { l12(0,755,6);
s4('s',t11(755),6); }} if (e0[755]==-1) { if (!(t7(t11(755),7) || d2(100)<75
|| t7(462,4) || !(t7(271,4)))) { l12(0,755,7); s4('s',t11(755),7); }} if
(e0[755]==-1) { if (!(t7(t11(755),8) || d2(100)<75 || !(t7(324,4)))) { l12(0,755,8);
s4('s',t11(755),8); }} if (e0[755]==-1) { if (!(t7(t11(755),11) || d2(100)<75
|| t7(58,4) || t7(228,8))) { l12(0,755,11); s4('s',t11(755),11); }} if (e0[755]==-1)
{ if (!(t7(t11(755),10) || d2(100)<75 || !(t7(35,4)))) { l12(0,755,10);
s4('s',t11(755),10); }} if (e0[755]==-1) { if (!(t7(t11(755),12) || d2(100)<75
|| !(t7(415,4)) || t7(420,4))) { l12(0,755,12); s4('s',t11(755),12); }}
if (e0[755]==-1) { if (!(t7(t11(755),5) || d2(100)<85)) { l12(0,755,5);
s4('s',t11(755),5); }} e0[756] = d2(100-20+1)+20; if (e0[755]>-1) { f3(677,1280);
e0[677] += e0[755]; i7(0,776,0); i7(2,677,0); e0[756] += 100; }} } int a27()
{ if (d2(100)<20) { p9(434,-2); } p9(432,-2); } int u23() { if (t7(116,13))
{ i7(64,1333,0); } s4('s',116,13); i7(64,1332,0); } int e26() { if (e0[715]<1)
{ return 0; } l12(0,700,0); s4('s',95,15); *v7(675)= -1; e0[675]=r0-1; while
(++e0[675]<=n1) { if (t7(t11(675),3)) { s4('c',t11(675),14); if (t7(t11(675),4)
&& !(t7(t11(675),15)) && !g10(t11(e0[675]),-1)) { t10(676,675); if (!(t7(t11(676),7)
|| t7(t11(676),5))) { if (!(t7(t11(676),10))) { e0[700] += 1; s4('s',t11(675),14);
}}}}} s4('c',95,15); if (e0[700]>0) { e0[701] = d2(e0[700]); e0[701] +=
1; *v7(674)= -1; e0[674]=r0-1; while (++e0[674]<=n1) { if (e0[701]>0 &&
t7(t11(674),3) && t7(t11(674),14)) { e0[701] -= 1; if (e0[701]==0) { t10(676,674);
l12(1,675,674); }}} l12(1,699,760); e0[699] *= 100; e0[699] /= e0[715];
e0[699] *= e0[134]; if (d2(100)<e0[699]) { if (!(t7(t11(675),5))) { return
0; } e0[701] = d2(e0[760]); e0[701] += 1; *v7(674)= -1; e0[674]=r0-1; while
(++e0[674]<=n1) { if (e0[701]>0 && j0[e0[674]]==435) { e0[701] -= 1; if
(e0[701]==0) { if (t7(t11(674),5) || e0[674]==e0[686]) { return 0; } e0[760]
-= 1; s9(e0[674],e0[676]); }}}} e0[760] += 1; s9(e0[675],435); } } int a28()
{ if (e0[697]==1) { l12(1,700,669); } else { l12(1,700,670); } if ((513<=e0[700]
&& e0[700]<=522)) { e0[700] += 4; f3(701,522); if (!(e0[700]<e0[701])) {
e0[700] -= 8; } if (e0[697]==1) { b10(9,700); } else { b10(10,700); }} }
int g32() { l12(0,673,0); if (e0[697]==1) { l12(1,675,669); } else { l12(1,675,670);
} if (!(t7(t11(675),0))) { return 0; } if (g10(t11(e0[675]),-1)) { return
0; } if (m1(102)) { if (t7(102,4) && g10(104,-1) && !g10(102,-1)) { return
0; }} if (!(t7(t11(675),13) || t7(t11(675),14))) { return 0; } if (m1(27))
{ return 0; } if (t7(t11(675),13)) { if (!(e0[w9]==378)) { return 0; } }
else { if (!(e0[w9]==379)) { return 0; }} if (m1(534)) { if (m1(134)) {
i7(64,915,0); } if (t7(t11(675),4)) { i7(76,1378,670); } if (e0[705]<e0[721])
{ s4('s',t11(675),4); } else { g12(); i7(64,897,0); }} t10(673,675); s9(e0[675],e0[671]);
} int i42() { if (!(e0[673]==0)) { if (e0[697]==1) { l12(1,675,669); } else
{ l12(1,675,670); } if (!(t7(t11(675),0))) { return 0; } if (!(m5(t11(e0[675]),-1)))
{ s9(e0[675],e0[673]); }} } int r28() { if (e0[w9]==147 || e0[w9]==419 ||
e0[w9]==370 || e0[w9]==380) { i7(64,1377,0); } i7(76,829,147); } int u24()
{ if (m1(534)) { if (q8(102,-1)) { return 0; } if (m5(104,-1)) { i7(76,813,670);
} if (!(g10(104,-1))) { if (e0[w9]==379) { if (t7(104,4)) { i7(76,1378,670);
} } else { return 0; }} if (e0[705]<e0[721]) { s9(104,r5); s4('s',104,4);
l12(0,673,0); i7(12,1489,669); i7(76,1490,670); } g12(); i7(64,897,0); }
if (m1(535) || m1(557)) { if (m5(102,-1)) { return 0; } if (m5(104,-1))
{ s9(104,w9); i7(12,1489,669); i7(76,1490,670); } i7(76,1027,670); } if
(m1(547)) { if (m5(102,-1) || m5(104,-1)) { i7(64,828,0); } i7(76,1027,670);
} if (m1(571)) { if (g10(102,-1) && !m5(104,-1) || m5(102,-1)) { i7(76,1541,670);
} else { s4('s',t11(697),4); i7(0,104,0); s4('c',t11(697),4); longjmp(n0,1);
} } else { i7(64,1396,0); } } int k21() { if (!(e0[717]==3)) { i7(64,1065,0);
} if (!(m5(107,-1))) { i7(64,1066,0); } if (t7(107,15)) { i7(64,1397,0);
} i7(9,1387,20); if (y10(1388)) { s4('s',107,15); e0[707] += 20; i7(64,1389,0);
} i7(64,1398,0); } int e27() { if (e0[718]==0 || e0[717]>2) { l12(0,708,10);
} else { l12(0,708,0); } l12(0,709,10); *v7(675)= -1; e0[675]=r0-1; while
(++e0[675]<=n1) { if (t7(t11(675),5)) { if (j0[e0[675]]==141 || j0[e0[675]]==243)
{ e0[708] += 15; } else { if (t7(t11(675),4)) { e0[708] += 7; }} e0[709]
+= 15; }} if (j0[95]==141) { e0[708] -= 8; } else { if (j0[95]==140) { e0[708]
+= 8; }} if (!(t7(80,5))) { e0[709] += 15; } if (t7(97,4)) { e0[708] +=
1; if (j0[97]==141) { e0[708] += 1; }} if (j0[108]!=236) { e0[708] += 1;
} e0[709] += 1; if (t7(147,4) || t7(163,4)) { e0[708] += 20; if (t7(324,4))
{ e0[708] += 10; } if (t7(377,4)) { e0[708] += 10; } if (t7(253,4)) { e0[708]
+= 10; } if (t7(290,4)) { e0[708] += 15; } if (t7(27,13)) { e0[708] += 8;
}} e0[709] += 73; l12(1,699,717); e0[699] *= 16; e0[708] += e0[699]; e0[709]
+= 96; l12(1,702,706); e0[702] *= 10; e0[708] -= e0[702]; e0[708] -= e0[707];
if (e0[708]<0) { l12(0,708,0); } } int a29() { e27(); i7(13,1033,708); i7(13,1035,709);
i7(13,1036,712); i7(0,776,0); l12(1,700,708); if (e0[708]<30) { i7(0,1041,0);
e0[700] -= 30; } else { if (e0[708]<100) { i7(0,1042,0); e0[700] -= 100;
} else { if (e0[708]<200) { i7(0,1043,0); e0[700] -= 200; } else { if (e0[708]<300)
{ i7(0,1044,0); e0[700] -= 300; } else { if (e0[708]<400) { i7(0,1045,0);
e0[700] -= 400; } else { if (e0[708]<500) { i7(0,1046,0); e0[700] -= 500;
} else { if (e0[708]<600) { i7(0,1047,0); e0[700] -= 600; } else { if (e0[708]<650)
{ i7(0,1048,0); e0[700] -= 650; } else { if (e0[708]<660) { i7(0,1049,0);
e0[700] -= 660; } else { i7(0,1050,0); l12(0,700,0); }}}}}}}}} i7(0,776,0);
e0[700] *= -1; if (e0[700]>0) { if (e0[700]==1) { i7(0,1051,0); } else {
i7(13,1052,700); }} i7(0,776,0); r7(); } int b28() { if (e0[14]<8) { e0[14]
= d2(8); } e0[15] = d2(8); if (g10(99,1)) { s9(15,484); } else { s9(15,256);
if (e0[w9]==256 && !(t7(t11(697),0))) { i7(0,15,0); }} } int j38() { l12(0,718,0);
g12(); i7(0,776,0); s4('c',t11(710),3); s4('c',t11(710),1); s4('c',95,13);
if (e0[95]==2) { l12(0,95,3); } if (e0[w9]==432 || e0[w9]==256) { p9(485,-1);
} l12(0,17,0); s9(17,484); if (!(j0[121]==485)) { s9(121,484); } if (e0[25]==1)
{ l12(0,25,0); } else { if (e0[25]==3) { l12(0,25,2); }} s9(14,255); l12(0,14,8);
if (e0[43]>1) { l12(0,43,1); } if (e0[35]==1) { l12(0,35,0); l12(0,683,0);
s4('c',35,13); } e0[706] += 1; if (e0[717]>1) { if (e0[717]==2) { i7(0,935,0);
} else { e0[706] -= 1; } a29(); } f3(677,885); e0[677] += e0[706]; e0[677]
+= e0[706]; if (y10(e0[677])) { e0[677] += 1; i7(2,677,0); i7(0,776,0);
f3(700,894); if (e0[677]<e0[700]) { if (m5(53,-1)) { s9(53,485); s9(54,r5);
} if (m5(111,-1)) { l12(0,111,2); } if (m5(114,-1) && e0[114]!=1) { l12(0,114,2);
} *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1) { if (m5(t11(e0[675]),-1))
{ s9(e0[675],w9); }} l12(0,705,0); l12(0,99,0); s9(14,255); l12(0,14,8);
b28(); p9(141,-1); l12(0,672,0); s9(99,136); if (e0[698]==0) { if (!(t7(324,4)))
{ t10(676,39); if (e0[39]==3 || !(t7(t11(676),7))) { s9(99,485); }}} s9(134,484);
l12(0,134,0); s4('c',19,13); longjmp(n0,1); }} a29(); } int w25() { b26();
if (e0[699]==1) { i7(0,1594,0); j38(); } } int t35() { if (g10(121,-1))
{ if (e0[121]==6) { j38(); } e0[121] += 1; } } int j39() { l12(0,701,0);
l12(0,700,1); *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1) { if (q8(t11(e0[675]),-1))
{ s4('s',t11(675),4); if (e0[700]==1 && !(t7(t11(675),10))) { l12(0,700,0);
i7(0,776,0); } if (e0[701]==20) { l12(0,701,0); f3(674,134); if (e0[675]<e0[674])
{ if (!(y10(1589))) { f3(675,134); }} e0[675] -= 1; } else { e0[701] +=
1; s4('s',t11(675),4); i7(2,675,0); }}} } int y21() { i7(2,671,0); if ((437<=e0[671]
&& e0[671]<=460)) { i7(0,861,0); } if (e0[700]>0) { if (e0[w9]==463) { i7(2,684,0);
} else { if (e0[w9]==150 && e0[151]==0) { i7(0,1225,0); }}} if (t7(t11(671),15))
{ i7(0,876,0); } j39(); if (m5(38,-1)) { i7(0,939,0); } t35(); } int i43()
{ if (!g10(101,-1)) return 0; if (m5(101,-1)) { i7(76,813,101); } if (e0[101]==1)
{ s9(100,r5); s4('s',100,4); s9(101,r5); i7(12,1489,669); i7(64,1514,0);
} if (m5(100,-1)) { if (m5(102,-1)) { i7(64,815,0); } s4('c',149,8); s9(101,r5);
l12(0,101,1); i7(64,1495,0); } i7(64,816,0); } int i44() { if (!g10(100,-1))
return 0; if (m5(100,-1)) { i7(76,813,100); } s9(100,r5); i7(12,1489,669);
if (e0[101]==1) { s9(101,r5); s4('s',101,4); i7(64,1514,0); } i7(76,1490,670);
} int t36() { if (q8(134,-1)) { i7(64,921,0); } } int e28() { if (q8(78,-1))
{ if (e0[705]<e0[721]) { s9(78,r5); s9(79,485); i7(12,1489,669); i7(76,1490,670);
} g12(); i7(64,897,0); } } int p35() { if (g10(95,-1) && e0[705]<e0[721]
&& !m5(95,-1)) { if (e0[95]==0) { l12(0,95,1); s9(95,r5); i7(64,1352,0);
} if (j0[95]==e0[671]) { if (t7(95,13)) { i7(64,1354,0); } s4('s',95,13);
i7(64,1353,0); }} } int k22() { if (m5(95,-1)) { s9(95,w9); s4('c',95,13);
b26(); if (e0[95]>1 || e0[w9]==324) { if (e0[w9]==324) { i7(0,1454,0); }
else { i7(0,1455,0); } l12(0,95,3); if (g10(85,-1)) { h23(); } if (e0[699]==1)
{ i7(0,776,0); y21(); } } else { if (e0[699]==0) { i7(0,1355,0); } else
{ i7(0,1356,0); }} if (e0[w9]==393) { e24(); } if (e0[w9]==204) { s9(95,203);
} longjmp(n0,1); } } int k23() { if (!m5(97,-1)) return 0; if (!g10(34,-1))
return 0; s9(97,w9); i7(64,1385,0); } int s27() { if (!m5(101,-1)) return
0; s9(101,w9); l12(0,101,0); if (g10(7,-1)) { s9(7,485); s4('c',155,8);
i7(64,819,0); } if (g10(20,-1)) { if (e0[20]==0) { b27(); i7(64,957,0);
} i7(76,1492,670); } if (g10(22,-1)) { i7(64,958,0); } if (g10(24,-1)) {
b27(); i7(64,959,0); } if (g10(38,-1)) { if (e0[38]==0) { b27(); i7(64,960,0);
} i7(64,961,0); } if (g10(25,-1) && e0[25]<2) { i7(0,962,0); b27(); j38();
} if (g10(134,-1)) { b27(); i7(13,963,134); longjmp(n0,1); } if (g10(87,-1))
{ b27(); i7(64,964,0); } if (e0[w9]==379) { if (!(j0[104]==485)) { i7(0,1384,0);
i7(0,1372,0); j38(); }} i7(12,1492,670); if (e0[w9]==393) { e24(); } longjmp(n0,1);
} int g33() { if (!m5(100,-1)) return 0; s9(100,w9); i7(12,1489,669); if
(m5(101,-1)) { s9(101,w9); i7(0,1514,0); if (e0[w9]==204) { i7(0,776,0);
i7(0,1543,0); s9(101,203); } } else { i7(12,1490,670); } if (e0[w9]==204)
{ s9(100,203); } if (e0[w9]==393) { e24(); } longjmp(n0,1); } int e29()
{ if (!m5(53,-1)) return 0; s9(53,w9); if (e0[w9]==225) { i7(12,1489,669);
i7(12,1490,670); } else { if (e0[w9]==204) { i7(0,1216,0); s9(53,485); s9(54,203);
} else { if (m5(105,-1) || !g10(105,-1)) { l12(0,53,2); i7(0,53,0); s9(53,485);
s9(54,e0[671]); } else { l12(0,53,1); i7(0,53,0); l12(0,53,0); }}} if (e0[w9]==393)
{ e24(); } longjmp(n0,1); } int h24() { if (e0[670]==e0[112]) { l12(0,700,3);
} else { l12(0,700,4); } if (m5(111,t11(e0[700]))) { l12(0,111,2); if (g10(134,-1)
&& m1(557)) { s4('s',134,14); if (e0[134]==1) { i7(76,1062,670); } i7(76,1063,670);
} i7(76,875,670); } if (m5(114,t11(e0[700]))) { l12(0,114,2); i7(64,1367,0);
} } int a30() { if (!m5(111,-1)) return 0; s9(111,w9); l12(0,111,2); if
(e0[w9]==393) { i7(12,1544,670); i7(9,1601,0); s9(111,419); e24(); } if
(e0[w9]==415) { s9(111,419); i7(12,1544,670); i7(72,1263,0); } if (e0[w9]==204
|| e0[w9]==418 || e0[w9]==417) { i7(12,1544,670); if (e0[w9]==204) { s9(111,203);
s4('s',203,15); i7(72,1076,0); } s9(111,419); i7(72,1295,0); } i7(12,1489,669);
i7(12,1491,670); if (e0[111]==3) { s4('s',t11(671),15); i7(76,1493,112);
} if (e0[111]==4) { s4('s',t11(671),15); i7(76,1493,113); } i7(64,776,0);
} int b29() { if (q8(113,-1)) { if (!(m5(111,-1) || m5(114,-1))) { i7(76,909,113);
} if (m5(111,2)) { l12(0,111,4); i7(76,912,113); } if (m5(114,2)) { l12(0,114,4);
i7(76,913,113); } if (m5(111,-1) && m5(114,-1)) { i7(64,1368,0); } if (m5(111,-1))
{ i7(64,910,0); } i7(64,1369,0); } } int s28() { if (!(t7(t11(671),9)))
{ return 0; } if (m5(81,-1)) { if (e0[w9]==412) { if (!(m5(111,-1) || m5(114,-1)))
{ i7(64,1268,0); } } else { s4('s',81,13); s4('s',81,14); i7(64,1269,0);
}} if (!(m5(111,-1) || m5(114,-1))) { i7(76,909,112); } if (m5(111,2)) {
l12(0,111,3); i7(76,912,112); } if (m5(114,2)) { l12(0,114,3); i7(76,913,112);
} if (m5(114,-1) && m5(111,-1)) { i7(64,1368,0); } if (m5(111,-1)) { i7(64,910,0);
} i7(64,1369,0); } int u25() { if (e0[20]>0) { i7(64,976,0); } if (y10(836))
{ l12(0,20,1); s9(60,247); s9(117,247); s4('c',20,6); *v7(675)= -1; e0[675]=r0-1;
while (++e0[675]<=n1) { if (q8(t11(e0[675]),-1)) { s9(e0[675],247); }} p9(247,-1446);
} i7(12,1222,669); i7(76,1223,670); } int d35() { if (e0[717]<3) { b27();
i7(64,831,0); } i7(64,1399,0); } int h25() { if (y10(836)) { l12(1,699,721);
e0[699] -= e0[705]; e0[699] += 2; e0[699] *= 10; if (d2(100)<e0[699]) {
l12(0,704,1); i7(0,833,0); r27(); longjmp(n0,1); } if (d2(100)<e0[699])
{ i7(64,834,0); } i7(0,835,0); j38(); } i7(12,1222,669); i7(76,1223,670);
} int l33() { if (y10(836)) { if (d2(100)<50) { i7(64,1118,0); } i7(0,1119,0);
j38(); } i7(12,1222,669); i7(76,1223,670); } int e30() { if (!g10(38,-1))
return 0; if (m5(38,-1)) { i7(64,1697,0); } if (e0[w9]==299 && e0[38]<2)
{ i7(64,978,0); } s9(38,r5); i7(64,1696,0); } int x29() { if (!g10(116,-1))
return 0; if (e0[116]==0 && e0[705]<e0[721]) { if (e0[119]==2) { l12(0,733,5);
e0[116] += 1; s9(116,r5); s4('c',434,8); i7(64,1089,0); } i7(64,1090,0);
} } int s29() { if (!g10(56,-1)) return 0; if (e0[56]==0 && e0[705]<e0[721])
{ s9(56,r5); l12(0,56,1); e0[699] = d2(4); if (e0[699]==0) { f3(683,511);
} else { if (e0[699]==1) { f3(683,506); } else { if (e0[699]==2) { f3(683,505);
} else { f3(683,499); }}} s9(37,485); if (e0[35]==0) { i7(76,1132,683);
} i7(64,1133,0); } } int v37() { f3(677,1018); e0[677] += e0[706]; i7(2,677,0);
j38(); } int j40() { s4('s',t11(710),2); x28(); if (e0[701]==1) { return
0; } s4('s',t11(697),7); i7(0,776,0); e0[677] = d2(1199-1190+1)+1190; i7(2,677,0);
} int j41() { i7(0,936,0); *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1)
{ s4('c',t11(675),4); if (!(e0[675]==27)) { s4('c',t11(675),13); s4('c',t11(675),14);
} if (t7(t11(675),3)) { if (m5(t11(e0[675]),-1)) { s9(e0[675],w9); }}} s9(10,379);
s4('s',111,13); l12(0,111,2); s4('s',11,13); s4('s',107,13); l12(0,107,0);
s4('s',107,7); s4('c',107,15); s4('s',102,13); s4('s',99,13); l12(0,99,0);
l12(0,698,0); s4('s',134,13); l12(0,134,0); s4('s',104,14); s4('s',7,14);
s4('s',100,14); l12(0,100,1); s4('s',101,14); l12(0,101,1); s4('s',105,14);
l12(0,120,2); *v7(676)= -1; e0[676]=w0-1; while (++e0[676]<=q0) { if (t7(t11(676),7))
{ s4('c',t11(676),4); }} s4('s',461,4); s4('s',243,4); l12(0,717,3); l12(0,143,1);
l12(0,716,999); l12(0,672,0); p9(378,-2); } int i45() { *v7(675)= -1; e0[675]=r0-1;
while (++e0[675]<=n1) { if (t7(t11(675),5)) { if (!(j0[e0[675]]==141 ||
j0[e0[675]]==485)) { return 0; }}} if (!(j0[95]==141 || j0[95]==140 || j0[95]==485))
{ return 0; } if (!(m5(64,-1) || j0[64]==141 || j0[64]==485)) { return 0;
} if (j0[80]==141 || j0[80]==485) { l12(0,717,1); } } int w26() { s4('s',t11(697),7);
if (e0[43]>1) { return 0; } if (e0[717]==0) { s4('c',95,5); s4('c',64,5);
i45(); s4('s',64,5); s4('s',95,5); if (e0[717]==1) { l12(0,716,35); } else
{ e0[716] = d2(39-30+1)+30; } if (e0[66]>0) { e0[66] = d2(16) + 1; } if
(e0[116]>0) { e0[116] = d2(14) + 1; } if (e0[20]==1) { e0[723] -= e0[724];
if (e0[723]<0) { l12(0,20,2); }} if (!(j0[82]==484 || g10(82,-1))) { s9(82,485);
} if (t7(27,13) && !(t7(27,14)) && !g10(134,-1)) { s4('s',27,14); i7(0,1170,0);
l12(0,716,5); l12(1,724,716); return 0; } if (e0[119]==2) { e0[722] -= e0[724];
if (e0[722]<0) { l12(0,119,3); l12(0,722,40); i7(0,119,0); l12(0,119,0);
l12(0,721,7); l12(0,716,8); l12(1,724,716); return 0; }} if (t7(151,4) ||
t7(163,4)) { if (t7(t11(671),7) || t7(t11(671),5)) { e0[716] = d2(17-8+1)+8;
} else { b26(); if ((e0[699]==0 && e0[713]>150 && !(t7(19,4)) || t7(19,13)
|| d2(100)<10) && !(t7(49,4)) && !g10(134,-1) && !(t7(t11(671),3)) && !(t7(43,12)))
{ s4('c',19,13); l12(0,700,0); if (e0[64]==2) { s4('c',64,5); } if (t7(62,12))
{ s4('c',62,5); } if (t7(67,12)) { s4('c',67,5); } t10(676,95); if (e0[676]==e0[671])
{ s4('c',95,5); } *v7(675)= -1; e0[675]=r0-1; while (++e0[675]<=n1) { if
(g10(t11(e0[675]),1029)) { s9(e0[675],192); l12(0,700,1); }} s4('s',64,5);
s4('s',95,5); s4('s',62,5); s4('s',67,5); if (e0[700]==0) { if (t7(19,4)
|| e0[713]<150) { i7(0,930,0); s4('s',19,13); e0[716] = d2(13-4+1)+4; }
else { s9(49,192); s9(29,311); s4('s',19,4); i7(0,998,0); } } else { if
(t7(19,4)) { i7(0,932,0); } else { i7(0,931,0); s4('s',19,4); s9(49,192);
s9(29,311); }} } else { l12(1,699,715); e0[699] += 2; e0[699] *= 10; if
((g10(134,-1) || d2(100)<e0[699]) && e0[134]<e0[715]) { if (t7(115,4)) {
s9(134,e0[671]); e0[134] += 1; if (e0[134]==1) { b26(); if (e0[699]==0)
{ i7(0,134,0); } s4('s',134,13); s4('c',134,14); } if (e0[686]==0) { a26();
} } else { if (!(t7(t11(671),11))) { b26(); if (e0[699]==0) { s9(115,e0[671]);
s4('s',115,4); i7(0,783,0); }}}}}}} } else { if (e0[717]==1) { l12(0,717,2);
l12(0,4,0); i7(0,933,0); if (g10(134,-1)) { i7(13,1039,134); } s9(134,484);
l12(0,134,0); l12(0,715,0); l12(0,760,0); l12(0,686,0); l12(0,8,0); l12(0,30,0);
s9(22,485); s9(20,485); l12(0,22,4); s9(23,244); s4('s',8,10); s4('s',30,10);
s9(82,485); l12(0,716,30); } else { if (t7(t11(710),4)) { s4('c',t11(710),4);
l12(0,716,15); } else { j41(); }}} l12(1,724,716); } int x30() { if (m1(113))
{ w24(); } if (m1(112)) { r26(); } if (e0[697]==1) { if ((533<=e0[669] &&
e0[669]<=570) || m1(493)) { s4('s',t11(697),5); i7(76,1038,669); } if ((615<=e0[669]
&& e0[669]<=629)) { i7(0,937,0); } else { if ((630<=e0[669] && e0[669]<=659))
{ i7(12,818,669); } else { i7(0,1503,0); }} } else { if (e0[697]==2 && t7(t11(670),0))
{ if (m1(112) && t7(t11(671),9)) { i7(64,1588,0); } if (g10(t11(e0[670]),-1))
{ i7(12,1504,669); i7(12,1505,670); } else { i7(12,818,670); } } else {
if ((630<=e0[670] && e0[670]<=663)) { if (m1(550)) { i7(0,915,0); } else
{ if ((630<=e0[670] && e0[670]<=659)) { i7(12,818,670); } else { i7(12,1504,669);
i7(12,1505,670); }} } else { e0[699] = d2(1009-1005+1)+1005; i7(2,699,0);
}}} longjmp(n0,1); } int z25() { if (e0[698]>0) { if (e0[39]==3) { i7(0,1001,0);
} else { if (g10(39,-1)) { i7(0,1000,0); l12(0,39,3); l12(0,698,400); }
else { if (t7(39,4)) { i7(0,999,0); } else { if ((168<=e0[671] && e0[671]<=193))
{ i7(9,995,1); } else { if ((300<=e0[671] && e0[671]<=311)) { i7(9,995,2);
} else { i7(9,995,0); }}}}} } else { if (e0[717]==2) { j41(); } else { if
(g10(39,1)) { i7(0,1000,0); l12(0,39,3); e0[698] += 400; } else { i7(0,996,0);
l12(0,99,0); s4('s',t11(710),6); b28(); }}} } int h26() { s4('s',t11(671),14);
if ((329<=e0[671] && e0[671]<=364) || e0[w9]==328) { s4('s',328,14); *v7(676)=
-1; e0[676]=328; while (++e0[676]<=364) { s4('s',t11(676),14); }} if ((271<=e0[671]
&& e0[671]<=289)) { *v7(676)= -1; e0[676]=270; while (++e0[676]<=289) {
s4('s',t11(676),14); }} if ((385<=e0[671] && e0[671]<=390)) { *v7(676)=
-1; e0[676]=384; while (++e0[676]<=390) { s4('s',t11(676),14); }} if ((168<=e0[671]
&& e0[671]<=193)) { *v7(676)= -1; e0[676]=167; while (++e0[676]<=193) {
s4('s',t11(676),14); }} if ((300<=e0[671] && e0[671]<=311)) { *v7(676)=
-1; e0[676]=299; while (++e0[676]<=311) { s4('s',t11(676),14); }} } int
p36() { if (t7(t11(671),14) && !m1(580) || !(t7(t11(671),8))) { return 0;
} l12(0,677,0); if (e0[w9]==434 && m1(580)) { l12(0,720,0); i7(64,1474,0);
} if (e0[w9]==144 && e0[4]==0 && !m5(98,-1)) { f3(677,859); } if (e0[w9]==149
&& g10(101,0) && m5(102,-1)) { f3(677,806); } if (e0[w9]==155 && g10(7,-1))
{ if (t7(t11(735),0)) { if (!(m1(580) && !(t7(t11(671),14)))) { f3(677,1579);
} } else { if (j0[101]==485) { f3(677,810); } else { f3(677,808); }}} if
(e0[w9]==236) { f3(677,992); } if ((e0[w9]==228 || e0[w9]==227 || e0[w9]==229)
&& !(t7(229,4))) { f3(677,990); } if (e0[w9]==256) { f3(677,1140); } if
((168<=e0[671] && e0[671]<=193) || (300<=e0[671] && e0[671]<=311) || (385<=e0[671]
&& e0[671]<=390)) { f3(677,987); } if ((328<=e0[671] && e0[671]<=364)) {
f3(677,1217); } if ((271<=e0[671] && e0[671]<=289)) { if (m1(580) && !(t7(t11(671),14)))
{ return 0; } else { f3(677,1320); }} if (e0[w9]==427 || e0[w9]==428) {
f3(677,1654); } if (e0[w9]==239) { f3(677,1318); } if (g10(16,-1)) { f3(677,1431);
} if (e0[w9]==252) { f3(677,1436); } if (e0[w9]==264) { f3(677,1517); }
if (e0[w9]==254) { if (t7(t11(735),1)) { if (!(m1(580) && !(t7(t11(671),14))))
{ f3(677,1512); } } else { f3(677,1438); s4('s',t11(735),1); }} if (g10(24,-1))
{ f3(677,1441); } if (g10(35,-1)) { f3(677,1443); } if (e0[w9]==259) { if
(m1(580)) { f3(677,1452); } else { return 0; }} if (e0[677]==0) { return
0; } l12(0,720,0); if (y10(e0[677])) { i7(9,985,20); if (y10(986)) { e0[677]
+= 1; i7(2,677,0); e0[707] += 20; s4('c',t11(671),8); s4('c',t11(671),14);
e0[677] -= 1; if (e0[w9]==427) { s4('c',428,8); } if (e0[w9]==428) { s4('c',427,8);
} if (g10(7,-1)) { if (e0[677]==1579) { s4('c',t11(735),0); } else { s4('s',t11(671),8);
s4('s',t11(735),0); }} if (e0[w9]==254) { if (e0[677]==1512) { s4('c',t11(735),1);
} else { s4('s',t11(671),8); s4('s',t11(735),1); }} if (e0[w9]==228 || e0[w9]==227
|| e0[w9]==229) { s4('c',228,8); s4('c',229,8); s4('c',227,8); } if (e0[w9]==254
&& t7(197,4) && t7(t11(735),1)) { i7(0,1440,0); } if (g10(35,-1)) { s4('c',314,8);
s4('c',315,8); } if (e0[w9]==236) { s4('s',t11(735),2); } if ((328<=e0[671]
&& e0[671]<=364) || e0[w9]==328) { s4('c',328,8); *v7(676)= -1; e0[676]=328;
while (++e0[676]<=364) { s4('c',t11(676),8); }} if ((271<=e0[671] && e0[671]<=289))
{ *v7(676)= -1; e0[676]=270; while (++e0[676]<=289) { s4('c',t11(676),8);
}} if ((385<=e0[671] && e0[671]<=390)) { *v7(676)= -1; e0[676]=384; while
(++e0[676]<=390) { s4('c',t11(676),8); }} if ((168<=e0[671] && e0[671]<=193))
{ if (e0[168]==0) { i7(0,989,0); } else { i7(0,776,0); } *v7(676)= -1; e0[676]=167;
while (++e0[676]<=193) { s4('c',t11(676),8); }} if ((300<=e0[671] && e0[671]<=311))
{ *v7(676)= -1; e0[676]=299; while (++e0[676]<=311) { s4('c',t11(676),8);
}} if (g10(16,-1)) { s4('c',165,8); s4('c',166,8); } } else { h26(); } }
else { h26(); } } 