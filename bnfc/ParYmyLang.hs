{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParYmyLang where
import AbsYmyLang
import LexYmyLang
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn6 (Ident)
	| HappyAbsSyn7 (Integer)
	| HappyAbsSyn8 (String)
	| HappyAbsSyn9 (Program)
	| HappyAbsSyn10 (Stmt)
	| HappyAbsSyn11 ([Stmt])
	| HappyAbsSyn12 (Dec)
	| HappyAbsSyn13 ([Dec])
	| HappyAbsSyn14 (Type)
	| HappyAbsSyn17 (Decl_stmt)
	| HappyAbsSyn18 ([Ident])
	| HappyAbsSyn19 (Compound_stmt)
	| HappyAbsSyn20 (Iter_stmt)
	| HappyAbsSyn21 (Expression_stmt)
	| HappyAbsSyn22 (Selection_stmt)
	| HappyAbsSyn23 (Flow_stmt)
	| HappyAbsSyn24 (Print_stmt)
	| HappyAbsSyn25 (Exp)
	| HappyAbsSyn38 (Constant)
	| HappyAbsSyn39 ([Exp])
	| HappyAbsSyn42 (Unary_exp_operator)
	| HappyAbsSyn43 (Unary_log_operator)
	| HappyAbsSyn44 (Assignment_op)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106,
 happyReduce_107,
 happyReduce_108 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,1270) ([0,0,0,0,0,0,0,0,0,2184,8200,48586,119,0,0,34944,0,162,1795,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,64,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,16,2048,0,0,0,0,0,12288,3,0,0,0,0,136,0,0,0,0,0,32802,0,0,0,0,0,0,0,0,0,0,0,19456,16691,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34816,8,2592,28672,0,0,32768,136,41472,512,7,0,0,2184,8192,12298,112,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34944,0,162,1795,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,16,0,0,34944,128,162,1795,0,0,34816,8,2592,28720,0,0,32768,136,41472,768,7,0,0,2184,8200,12298,112,0,0,34944,0,162,1795,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2184,8200,48586,119,0,0,0,0,0,0,0,0,34816,2056,51744,32701,0,0,0,8192,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,8192,0,0,0,0,0,2184,8200,12298,112,0,0,0,64,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,56704,0,0,0,0,1024,0,0,0,0,0,0,32,0,0,0,0,0,4,0,0,0,0,0,0,0,1,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,2048,17,2048,0,0,0,0,0,0,0,0,0,0,2184,8192,12298,112,0,0,0,0,0,0,0,0,34816,8,2592,28720,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34816,8,2592,28672,0,0,32768,136,41472,0,7,0,0,2184,8192,10,112,0,0,34944,0,162,1792,0,0,34816,8,2592,28672,0,0,32768,136,41472,0,7,0,0,2184,8192,10,112,0,0,34944,0,162,1792,0,0,34816,8,2592,28672,0,0,32768,136,41472,0,7,0,0,2184,8192,10,112,0,0,34944,0,162,1792,0,0,34816,8,2592,28704,0,0,32768,136,41472,768,7,0,0,2184,8192,8202,112,0,0,0,0,512,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,816,0,0,0,0,0,13056,0,0,0,0,32768,8,0,0,0,0,0,136,0,0,0,0,0,2176,0,0,0,0,0,34816,0,0,0,0,0,8704,128,0,0,0,0,8192,2050,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,200,0,0,0,0,0,0,0,16,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34944,0,162,1795,0,0,34816,8,2592,28720,0,0,0,0,0,0,1,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,56704,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,3544,0,0,0,0,0,0,0,1,0,0,2184,8194,12298,112,0,0,34944,128,56482,1915,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2184,8200,48586,119,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,34944,128,56482,1915,0,0,4096,0,0,0,0,0,0,0,0,1,0,0,0,16400,0,0,0,0,0,0,0,0,0,0,0,2048,0,3544,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2184,8192,10,112,0,0,0,0,0,0,0,0,34816,8,2592,28704,0,0,0,0,0,0,0,0,0,3200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,55296,13,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,2184,8200,48586,119,0,0,0,32,0,0,0,0,34816,2056,51744,30653,0,0,0,0,0,0,0,0,0,2184,8200,48586,119,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","%start_pStmt","%start_pExp","Ident","Integer","String","Program","Stmt","ListStmt","Dec","ListDec","Type","Type2","Type1","Decl_stmt","ListIdent","Compound_stmt","Iter_stmt","Expression_stmt","Selection_stmt","Flow_stmt","Print_stmt","Exp","Exp2","Exp3","Exp4","Exp5","Exp6","Exp7","Exp8","Exp9","Exp10","Exp11","Exp12","Exp13","Constant","ListExp","ListExp9","Exp1","Unary_exp_operator","Unary_log_operator","Assignment_op","'!='","'%'","'%='","'('","')'","'*'","'*='","'+'","'++'","'+='","','","'-'","'--'","'-='","'->'","'/'","'/='","':'","'::'","';'","'<'","'<='","'='","'=='","'>'","'>='","'?'","'Any'","'Bool'","'False'","'Int'","'Invalid'","'String'","'True'","'Unit'","'['","']'","'and'","'break'","'continue'","'def'","'else'","'for'","'if'","'lambda'","'not'","'or'","'print'","'return'","'while'","'{'","'}'","L_ident","L_integ","L_quoted","%eof"]
        bit_start = st * 100
        bit_end = (st + 1) * 100
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..99]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (9) = happyGoto action_56
action_0 (11) = happyGoto action_57
action_0 _ = happyReduce_14

action_1 (48) = happyShift action_25
action_1 (52) = happyShift action_26
action_1 (56) = happyShift action_27
action_1 (64) = happyShift action_46
action_1 (74) = happyShift action_28
action_1 (78) = happyShift action_29
action_1 (80) = happyShift action_30
action_1 (83) = happyShift action_47
action_1 (84) = happyShift action_48
action_1 (85) = happyShift action_49
action_1 (87) = happyShift action_50
action_1 (88) = happyShift action_51
action_1 (89) = happyShift action_31
action_1 (90) = happyShift action_32
action_1 (92) = happyShift action_52
action_1 (93) = happyShift action_53
action_1 (94) = happyShift action_54
action_1 (95) = happyShift action_55
action_1 (97) = happyShift action_4
action_1 (98) = happyShift action_33
action_1 (99) = happyShift action_34
action_1 (6) = happyGoto action_35
action_1 (7) = happyGoto action_6
action_1 (8) = happyGoto action_7
action_1 (10) = happyGoto action_36
action_1 (12) = happyGoto action_37
action_1 (17) = happyGoto action_38
action_1 (19) = happyGoto action_39
action_1 (20) = happyGoto action_40
action_1 (21) = happyGoto action_41
action_1 (22) = happyGoto action_42
action_1 (23) = happyGoto action_43
action_1 (24) = happyGoto action_44
action_1 (25) = happyGoto action_45
action_1 (26) = happyGoto action_9
action_1 (27) = happyGoto action_10
action_1 (28) = happyGoto action_11
action_1 (29) = happyGoto action_12
action_1 (30) = happyGoto action_13
action_1 (31) = happyGoto action_14
action_1 (32) = happyGoto action_15
action_1 (33) = happyGoto action_16
action_1 (34) = happyGoto action_17
action_1 (35) = happyGoto action_18
action_1 (36) = happyGoto action_19
action_1 (37) = happyGoto action_20
action_1 (38) = happyGoto action_21
action_1 (41) = happyGoto action_22
action_1 (42) = happyGoto action_23
action_1 (43) = happyGoto action_24
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (48) = happyShift action_25
action_2 (52) = happyShift action_26
action_2 (56) = happyShift action_27
action_2 (74) = happyShift action_28
action_2 (78) = happyShift action_29
action_2 (80) = happyShift action_30
action_2 (89) = happyShift action_31
action_2 (90) = happyShift action_32
action_2 (97) = happyShift action_4
action_2 (98) = happyShift action_33
action_2 (99) = happyShift action_34
action_2 (6) = happyGoto action_5
action_2 (7) = happyGoto action_6
action_2 (8) = happyGoto action_7
action_2 (25) = happyGoto action_8
action_2 (26) = happyGoto action_9
action_2 (27) = happyGoto action_10
action_2 (28) = happyGoto action_11
action_2 (29) = happyGoto action_12
action_2 (30) = happyGoto action_13
action_2 (31) = happyGoto action_14
action_2 (32) = happyGoto action_15
action_2 (33) = happyGoto action_16
action_2 (34) = happyGoto action_17
action_2 (35) = happyGoto action_18
action_2 (36) = happyGoto action_19
action_2 (37) = happyGoto action_20
action_2 (38) = happyGoto action_21
action_2 (41) = happyGoto action_22
action_2 (42) = happyGoto action_23
action_2 (43) = happyGoto action_24
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (97) = happyShift action_4
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_3

action_5 _ = happyReduce_86

action_6 _ = happyReduce_89

action_7 _ = happyReduce_90

action_8 (100) = happyAccept
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_99

action_10 _ = happyReduce_53

action_11 (71) = happyShift action_104
action_11 (91) = happyShift action_105
action_11 _ = happyReduce_55

action_12 (82) = happyShift action_103
action_12 _ = happyReduce_57

action_13 _ = happyReduce_59

action_14 (45) = happyShift action_101
action_14 (68) = happyShift action_102
action_14 _ = happyReduce_61

action_15 (65) = happyShift action_97
action_15 (66) = happyShift action_98
action_15 (69) = happyShift action_99
action_15 (70) = happyShift action_100
action_15 _ = happyReduce_64

action_16 (52) = happyShift action_95
action_16 (56) = happyShift action_96
action_16 _ = happyReduce_69

action_17 (46) = happyShift action_92
action_17 (50) = happyShift action_93
action_17 (60) = happyShift action_94
action_17 _ = happyReduce_72

action_18 _ = happyReduce_76

action_19 (47) = happyShift action_82
action_19 (48) = happyShift action_83
action_19 (51) = happyShift action_84
action_19 (53) = happyShift action_85
action_19 (54) = happyShift action_86
action_19 (57) = happyShift action_87
action_19 (58) = happyShift action_88
action_19 (61) = happyShift action_89
action_19 (67) = happyShift action_90
action_19 (80) = happyShift action_91
action_19 (44) = happyGoto action_81
action_19 _ = happyReduce_79

action_20 _ = happyReduce_85

action_21 _ = happyReduce_87

action_22 _ = happyReduce_51

action_23 (48) = happyShift action_25
action_23 (52) = happyShift action_26
action_23 (56) = happyShift action_27
action_23 (74) = happyShift action_28
action_23 (78) = happyShift action_29
action_23 (80) = happyShift action_30
action_23 (97) = happyShift action_4
action_23 (98) = happyShift action_33
action_23 (99) = happyShift action_34
action_23 (6) = happyGoto action_5
action_23 (7) = happyGoto action_6
action_23 (8) = happyGoto action_7
action_23 (34) = happyGoto action_80
action_23 (35) = happyGoto action_18
action_23 (36) = happyGoto action_79
action_23 (37) = happyGoto action_20
action_23 (38) = happyGoto action_21
action_23 (42) = happyGoto action_23
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (48) = happyShift action_25
action_24 (52) = happyShift action_26
action_24 (56) = happyShift action_27
action_24 (74) = happyShift action_28
action_24 (78) = happyShift action_29
action_24 (80) = happyShift action_30
action_24 (90) = happyShift action_32
action_24 (97) = happyShift action_4
action_24 (98) = happyShift action_33
action_24 (99) = happyShift action_34
action_24 (6) = happyGoto action_5
action_24 (7) = happyGoto action_6
action_24 (8) = happyGoto action_7
action_24 (29) = happyGoto action_78
action_24 (30) = happyGoto action_13
action_24 (31) = happyGoto action_14
action_24 (32) = happyGoto action_15
action_24 (33) = happyGoto action_16
action_24 (34) = happyGoto action_17
action_24 (35) = happyGoto action_18
action_24 (36) = happyGoto action_79
action_24 (37) = happyGoto action_20
action_24 (38) = happyGoto action_21
action_24 (42) = happyGoto action_23
action_24 (43) = happyGoto action_24
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (48) = happyShift action_25
action_25 (52) = happyShift action_26
action_25 (56) = happyShift action_27
action_25 (74) = happyShift action_28
action_25 (78) = happyShift action_29
action_25 (80) = happyShift action_30
action_25 (89) = happyShift action_31
action_25 (90) = happyShift action_32
action_25 (97) = happyShift action_4
action_25 (98) = happyShift action_33
action_25 (99) = happyShift action_34
action_25 (6) = happyGoto action_5
action_25 (7) = happyGoto action_6
action_25 (8) = happyGoto action_7
action_25 (25) = happyGoto action_77
action_25 (26) = happyGoto action_9
action_25 (27) = happyGoto action_10
action_25 (28) = happyGoto action_11
action_25 (29) = happyGoto action_12
action_25 (30) = happyGoto action_13
action_25 (31) = happyGoto action_14
action_25 (32) = happyGoto action_15
action_25 (33) = happyGoto action_16
action_25 (34) = happyGoto action_17
action_25 (35) = happyGoto action_18
action_25 (36) = happyGoto action_19
action_25 (37) = happyGoto action_20
action_25 (38) = happyGoto action_21
action_25 (41) = happyGoto action_22
action_25 (42) = happyGoto action_23
action_25 (43) = happyGoto action_24
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_100

action_27 _ = happyReduce_101

action_28 _ = happyReduce_92

action_29 _ = happyReduce_91

action_30 (48) = happyShift action_25
action_30 (52) = happyShift action_26
action_30 (56) = happyShift action_27
action_30 (74) = happyShift action_28
action_30 (78) = happyShift action_29
action_30 (80) = happyShift action_30
action_30 (89) = happyShift action_31
action_30 (90) = happyShift action_32
action_30 (97) = happyShift action_4
action_30 (98) = happyShift action_33
action_30 (99) = happyShift action_34
action_30 (6) = happyGoto action_5
action_30 (7) = happyGoto action_6
action_30 (8) = happyGoto action_7
action_30 (25) = happyGoto action_75
action_30 (26) = happyGoto action_9
action_30 (27) = happyGoto action_10
action_30 (28) = happyGoto action_11
action_30 (29) = happyGoto action_12
action_30 (30) = happyGoto action_13
action_30 (31) = happyGoto action_14
action_30 (32) = happyGoto action_15
action_30 (33) = happyGoto action_16
action_30 (34) = happyGoto action_17
action_30 (35) = happyGoto action_18
action_30 (36) = happyGoto action_19
action_30 (37) = happyGoto action_20
action_30 (38) = happyGoto action_21
action_30 (39) = happyGoto action_76
action_30 (41) = happyGoto action_22
action_30 (42) = happyGoto action_23
action_30 (43) = happyGoto action_24
action_30 _ = happyReduce_93

action_31 (97) = happyShift action_4
action_31 (6) = happyGoto action_66
action_31 (12) = happyGoto action_73
action_31 (13) = happyGoto action_74
action_31 _ = happyReduce_17

action_32 _ = happyReduce_102

action_33 _ = happyReduce_4

action_34 _ = happyReduce_5

action_35 (63) = happyShift action_72
action_35 _ = happyReduce_86

action_36 (100) = happyAccept
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (64) = happyShift action_71
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_7

action_39 _ = happyReduce_8

action_40 _ = happyReduce_11

action_41 _ = happyReduce_9

action_42 _ = happyReduce_10

action_43 _ = happyReduce_12

action_44 _ = happyReduce_13

action_45 (64) = happyShift action_70
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_41

action_47 (64) = happyShift action_69
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (64) = happyShift action_68
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (97) = happyShift action_4
action_49 (6) = happyGoto action_66
action_49 (12) = happyGoto action_67
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (48) = happyShift action_25
action_50 (52) = happyShift action_26
action_50 (56) = happyShift action_27
action_50 (64) = happyShift action_46
action_50 (74) = happyShift action_28
action_50 (78) = happyShift action_29
action_50 (80) = happyShift action_30
action_50 (89) = happyShift action_31
action_50 (90) = happyShift action_32
action_50 (97) = happyShift action_4
action_50 (98) = happyShift action_33
action_50 (99) = happyShift action_34
action_50 (6) = happyGoto action_5
action_50 (7) = happyGoto action_6
action_50 (8) = happyGoto action_7
action_50 (21) = happyGoto action_65
action_50 (25) = happyGoto action_45
action_50 (26) = happyGoto action_9
action_50 (27) = happyGoto action_10
action_50 (28) = happyGoto action_11
action_50 (29) = happyGoto action_12
action_50 (30) = happyGoto action_13
action_50 (31) = happyGoto action_14
action_50 (32) = happyGoto action_15
action_50 (33) = happyGoto action_16
action_50 (34) = happyGoto action_17
action_50 (35) = happyGoto action_18
action_50 (36) = happyGoto action_19
action_50 (37) = happyGoto action_20
action_50 (38) = happyGoto action_21
action_50 (41) = happyGoto action_22
action_50 (42) = happyGoto action_23
action_50 (43) = happyGoto action_24
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (48) = happyShift action_25
action_51 (52) = happyShift action_26
action_51 (56) = happyShift action_27
action_51 (74) = happyShift action_28
action_51 (78) = happyShift action_29
action_51 (80) = happyShift action_30
action_51 (89) = happyShift action_31
action_51 (90) = happyShift action_32
action_51 (97) = happyShift action_4
action_51 (98) = happyShift action_33
action_51 (99) = happyShift action_34
action_51 (6) = happyGoto action_5
action_51 (7) = happyGoto action_6
action_51 (8) = happyGoto action_7
action_51 (25) = happyGoto action_64
action_51 (26) = happyGoto action_9
action_51 (27) = happyGoto action_10
action_51 (28) = happyGoto action_11
action_51 (29) = happyGoto action_12
action_51 (30) = happyGoto action_13
action_51 (31) = happyGoto action_14
action_51 (32) = happyGoto action_15
action_51 (33) = happyGoto action_16
action_51 (34) = happyGoto action_17
action_51 (35) = happyGoto action_18
action_51 (36) = happyGoto action_19
action_51 (37) = happyGoto action_20
action_51 (38) = happyGoto action_21
action_51 (41) = happyGoto action_22
action_51 (42) = happyGoto action_23
action_51 (43) = happyGoto action_24
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (48) = happyShift action_25
action_52 (52) = happyShift action_26
action_52 (56) = happyShift action_27
action_52 (74) = happyShift action_28
action_52 (78) = happyShift action_29
action_52 (80) = happyShift action_30
action_52 (89) = happyShift action_31
action_52 (90) = happyShift action_32
action_52 (97) = happyShift action_4
action_52 (98) = happyShift action_33
action_52 (99) = happyShift action_34
action_52 (6) = happyGoto action_5
action_52 (7) = happyGoto action_6
action_52 (8) = happyGoto action_7
action_52 (25) = happyGoto action_63
action_52 (26) = happyGoto action_9
action_52 (27) = happyGoto action_10
action_52 (28) = happyGoto action_11
action_52 (29) = happyGoto action_12
action_52 (30) = happyGoto action_13
action_52 (31) = happyGoto action_14
action_52 (32) = happyGoto action_15
action_52 (33) = happyGoto action_16
action_52 (34) = happyGoto action_17
action_52 (35) = happyGoto action_18
action_52 (36) = happyGoto action_19
action_52 (37) = happyGoto action_20
action_52 (38) = happyGoto action_21
action_52 (41) = happyGoto action_22
action_52 (42) = happyGoto action_23
action_52 (43) = happyGoto action_24
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (48) = happyShift action_25
action_53 (52) = happyShift action_26
action_53 (56) = happyShift action_27
action_53 (64) = happyShift action_62
action_53 (74) = happyShift action_28
action_53 (78) = happyShift action_29
action_53 (80) = happyShift action_30
action_53 (89) = happyShift action_31
action_53 (90) = happyShift action_32
action_53 (97) = happyShift action_4
action_53 (98) = happyShift action_33
action_53 (99) = happyShift action_34
action_53 (6) = happyGoto action_5
action_53 (7) = happyGoto action_6
action_53 (8) = happyGoto action_7
action_53 (25) = happyGoto action_61
action_53 (26) = happyGoto action_9
action_53 (27) = happyGoto action_10
action_53 (28) = happyGoto action_11
action_53 (29) = happyGoto action_12
action_53 (30) = happyGoto action_13
action_53 (31) = happyGoto action_14
action_53 (32) = happyGoto action_15
action_53 (33) = happyGoto action_16
action_53 (34) = happyGoto action_17
action_53 (35) = happyGoto action_18
action_53 (36) = happyGoto action_19
action_53 (37) = happyGoto action_20
action_53 (38) = happyGoto action_21
action_53 (41) = happyGoto action_22
action_53 (42) = happyGoto action_23
action_53 (43) = happyGoto action_24
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (48) = happyShift action_25
action_54 (52) = happyShift action_26
action_54 (56) = happyShift action_27
action_54 (74) = happyShift action_28
action_54 (78) = happyShift action_29
action_54 (80) = happyShift action_30
action_54 (89) = happyShift action_31
action_54 (90) = happyShift action_32
action_54 (97) = happyShift action_4
action_54 (98) = happyShift action_33
action_54 (99) = happyShift action_34
action_54 (6) = happyGoto action_5
action_54 (7) = happyGoto action_6
action_54 (8) = happyGoto action_7
action_54 (25) = happyGoto action_60
action_54 (26) = happyGoto action_9
action_54 (27) = happyGoto action_10
action_54 (28) = happyGoto action_11
action_54 (29) = happyGoto action_12
action_54 (30) = happyGoto action_13
action_54 (31) = happyGoto action_14
action_54 (32) = happyGoto action_15
action_54 (33) = happyGoto action_16
action_54 (34) = happyGoto action_17
action_54 (35) = happyGoto action_18
action_54 (36) = happyGoto action_19
action_54 (37) = happyGoto action_20
action_54 (38) = happyGoto action_21
action_54 (41) = happyGoto action_22
action_54 (42) = happyGoto action_23
action_54 (43) = happyGoto action_24
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (11) = happyGoto action_59
action_55 _ = happyReduce_14

action_56 (100) = happyAccept
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (48) = happyShift action_25
action_57 (52) = happyShift action_26
action_57 (56) = happyShift action_27
action_57 (64) = happyShift action_46
action_57 (74) = happyShift action_28
action_57 (78) = happyShift action_29
action_57 (80) = happyShift action_30
action_57 (83) = happyShift action_47
action_57 (84) = happyShift action_48
action_57 (85) = happyShift action_49
action_57 (87) = happyShift action_50
action_57 (88) = happyShift action_51
action_57 (89) = happyShift action_31
action_57 (90) = happyShift action_32
action_57 (92) = happyShift action_52
action_57 (93) = happyShift action_53
action_57 (94) = happyShift action_54
action_57 (95) = happyShift action_55
action_57 (97) = happyShift action_4
action_57 (98) = happyShift action_33
action_57 (99) = happyShift action_34
action_57 (6) = happyGoto action_35
action_57 (7) = happyGoto action_6
action_57 (8) = happyGoto action_7
action_57 (10) = happyGoto action_58
action_57 (12) = happyGoto action_37
action_57 (17) = happyGoto action_38
action_57 (19) = happyGoto action_39
action_57 (20) = happyGoto action_40
action_57 (21) = happyGoto action_41
action_57 (22) = happyGoto action_42
action_57 (23) = happyGoto action_43
action_57 (24) = happyGoto action_44
action_57 (25) = happyGoto action_45
action_57 (26) = happyGoto action_9
action_57 (27) = happyGoto action_10
action_57 (28) = happyGoto action_11
action_57 (29) = happyGoto action_12
action_57 (30) = happyGoto action_13
action_57 (31) = happyGoto action_14
action_57 (32) = happyGoto action_15
action_57 (33) = happyGoto action_16
action_57 (34) = happyGoto action_17
action_57 (35) = happyGoto action_18
action_57 (36) = happyGoto action_19
action_57 (37) = happyGoto action_20
action_57 (38) = happyGoto action_21
action_57 (41) = happyGoto action_22
action_57 (42) = happyGoto action_23
action_57 (43) = happyGoto action_24
action_57 _ = happyReduce_6

action_58 _ = happyReduce_15

action_59 (48) = happyShift action_25
action_59 (52) = happyShift action_26
action_59 (56) = happyShift action_27
action_59 (64) = happyShift action_46
action_59 (74) = happyShift action_28
action_59 (78) = happyShift action_29
action_59 (80) = happyShift action_30
action_59 (83) = happyShift action_47
action_59 (84) = happyShift action_48
action_59 (85) = happyShift action_49
action_59 (87) = happyShift action_50
action_59 (88) = happyShift action_51
action_59 (89) = happyShift action_31
action_59 (90) = happyShift action_32
action_59 (92) = happyShift action_52
action_59 (93) = happyShift action_53
action_59 (94) = happyShift action_54
action_59 (95) = happyShift action_55
action_59 (96) = happyShift action_146
action_59 (97) = happyShift action_4
action_59 (98) = happyShift action_33
action_59 (99) = happyShift action_34
action_59 (6) = happyGoto action_35
action_59 (7) = happyGoto action_6
action_59 (8) = happyGoto action_7
action_59 (10) = happyGoto action_58
action_59 (12) = happyGoto action_37
action_59 (17) = happyGoto action_38
action_59 (19) = happyGoto action_39
action_59 (20) = happyGoto action_40
action_59 (21) = happyGoto action_41
action_59 (22) = happyGoto action_42
action_59 (23) = happyGoto action_43
action_59 (24) = happyGoto action_44
action_59 (25) = happyGoto action_45
action_59 (26) = happyGoto action_9
action_59 (27) = happyGoto action_10
action_59 (28) = happyGoto action_11
action_59 (29) = happyGoto action_12
action_59 (30) = happyGoto action_13
action_59 (31) = happyGoto action_14
action_59 (32) = happyGoto action_15
action_59 (33) = happyGoto action_16
action_59 (34) = happyGoto action_17
action_59 (35) = happyGoto action_18
action_59 (36) = happyGoto action_19
action_59 (37) = happyGoto action_20
action_59 (38) = happyGoto action_21
action_59 (41) = happyGoto action_22
action_59 (42) = happyGoto action_23
action_59 (43) = happyGoto action_24
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (62) = happyShift action_145
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (64) = happyShift action_144
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_48

action_63 (64) = happyShift action_143
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (62) = happyShift action_142
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (48) = happyShift action_25
action_65 (52) = happyShift action_26
action_65 (56) = happyShift action_27
action_65 (64) = happyShift action_46
action_65 (74) = happyShift action_28
action_65 (78) = happyShift action_29
action_65 (80) = happyShift action_30
action_65 (89) = happyShift action_31
action_65 (90) = happyShift action_32
action_65 (97) = happyShift action_4
action_65 (98) = happyShift action_33
action_65 (99) = happyShift action_34
action_65 (6) = happyGoto action_5
action_65 (7) = happyGoto action_6
action_65 (8) = happyGoto action_7
action_65 (21) = happyGoto action_141
action_65 (25) = happyGoto action_45
action_65 (26) = happyGoto action_9
action_65 (27) = happyGoto action_10
action_65 (28) = happyGoto action_11
action_65 (29) = happyGoto action_12
action_65 (30) = happyGoto action_13
action_65 (31) = happyGoto action_14
action_65 (32) = happyGoto action_15
action_65 (33) = happyGoto action_16
action_65 (34) = happyGoto action_17
action_65 (35) = happyGoto action_18
action_65 (36) = happyGoto action_19
action_65 (37) = happyGoto action_20
action_65 (38) = happyGoto action_21
action_65 (41) = happyGoto action_22
action_65 (42) = happyGoto action_23
action_65 (43) = happyGoto action_24
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (63) = happyShift action_72
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (48) = happyShift action_140
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_45

action_69 _ = happyReduce_46

action_70 _ = happyReduce_42

action_71 _ = happyReduce_32

action_72 (48) = happyShift action_132
action_72 (72) = happyShift action_133
action_72 (73) = happyShift action_134
action_72 (75) = happyShift action_135
action_72 (76) = happyShift action_136
action_72 (77) = happyShift action_137
action_72 (79) = happyShift action_138
action_72 (80) = happyShift action_139
action_72 (14) = happyGoto action_129
action_72 (15) = happyGoto action_130
action_72 (16) = happyGoto action_131
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (55) = happyShift action_128
action_73 _ = happyReduce_18

action_74 (62) = happyShift action_127
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (55) = happyShift action_126
action_75 _ = happyReduce_94

action_76 (81) = happyShift action_125
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (49) = happyShift action_124
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (82) = happyShift action_103
action_78 _ = happyReduce_60

action_79 (48) = happyShift action_83
action_79 (53) = happyShift action_85
action_79 (57) = happyShift action_87
action_79 (80) = happyShift action_91
action_79 _ = happyReduce_79

action_80 (46) = happyShift action_92
action_80 (50) = happyShift action_93
action_80 (60) = happyShift action_94
action_80 _ = happyReduce_78

action_81 (48) = happyShift action_25
action_81 (52) = happyShift action_26
action_81 (56) = happyShift action_27
action_81 (74) = happyShift action_28
action_81 (78) = happyShift action_29
action_81 (80) = happyShift action_30
action_81 (89) = happyShift action_31
action_81 (90) = happyShift action_32
action_81 (97) = happyShift action_4
action_81 (98) = happyShift action_33
action_81 (99) = happyShift action_34
action_81 (6) = happyGoto action_5
action_81 (7) = happyGoto action_6
action_81 (8) = happyGoto action_7
action_81 (25) = happyGoto action_123
action_81 (26) = happyGoto action_9
action_81 (27) = happyGoto action_10
action_81 (28) = happyGoto action_11
action_81 (29) = happyGoto action_12
action_81 (30) = happyGoto action_13
action_81 (31) = happyGoto action_14
action_81 (32) = happyGoto action_15
action_81 (33) = happyGoto action_16
action_81 (34) = happyGoto action_17
action_81 (35) = happyGoto action_18
action_81 (36) = happyGoto action_19
action_81 (37) = happyGoto action_20
action_81 (38) = happyGoto action_21
action_81 (41) = happyGoto action_22
action_81 (42) = happyGoto action_23
action_81 (43) = happyGoto action_24
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_106

action_83 (48) = happyShift action_25
action_83 (52) = happyShift action_26
action_83 (56) = happyShift action_27
action_83 (74) = happyShift action_28
action_83 (78) = happyShift action_29
action_83 (80) = happyShift action_30
action_83 (89) = happyShift action_31
action_83 (90) = happyShift action_32
action_83 (97) = happyShift action_4
action_83 (98) = happyShift action_33
action_83 (99) = happyShift action_34
action_83 (6) = happyGoto action_5
action_83 (7) = happyGoto action_6
action_83 (8) = happyGoto action_7
action_83 (25) = happyGoto action_75
action_83 (26) = happyGoto action_9
action_83 (27) = happyGoto action_10
action_83 (28) = happyGoto action_11
action_83 (29) = happyGoto action_12
action_83 (30) = happyGoto action_13
action_83 (31) = happyGoto action_14
action_83 (32) = happyGoto action_15
action_83 (33) = happyGoto action_16
action_83 (34) = happyGoto action_17
action_83 (35) = happyGoto action_18
action_83 (36) = happyGoto action_19
action_83 (37) = happyGoto action_20
action_83 (38) = happyGoto action_21
action_83 (39) = happyGoto action_122
action_83 (41) = happyGoto action_22
action_83 (42) = happyGoto action_23
action_83 (43) = happyGoto action_24
action_83 _ = happyReduce_93

action_84 _ = happyReduce_104

action_85 _ = happyReduce_80

action_86 _ = happyReduce_107

action_87 _ = happyReduce_81

action_88 _ = happyReduce_108

action_89 _ = happyReduce_105

action_90 _ = happyReduce_103

action_91 (48) = happyShift action_25
action_91 (52) = happyShift action_26
action_91 (56) = happyShift action_27
action_91 (74) = happyShift action_28
action_91 (78) = happyShift action_29
action_91 (80) = happyShift action_30
action_91 (97) = happyShift action_4
action_91 (98) = happyShift action_33
action_91 (99) = happyShift action_34
action_91 (6) = happyGoto action_5
action_91 (7) = happyGoto action_6
action_91 (8) = happyGoto action_7
action_91 (33) = happyGoto action_120
action_91 (34) = happyGoto action_17
action_91 (35) = happyGoto action_18
action_91 (36) = happyGoto action_79
action_91 (37) = happyGoto action_20
action_91 (38) = happyGoto action_21
action_91 (40) = happyGoto action_121
action_91 (42) = happyGoto action_23
action_91 _ = happyReduce_96

action_92 (48) = happyShift action_25
action_92 (52) = happyShift action_26
action_92 (56) = happyShift action_27
action_92 (74) = happyShift action_28
action_92 (78) = happyShift action_29
action_92 (80) = happyShift action_30
action_92 (97) = happyShift action_4
action_92 (98) = happyShift action_33
action_92 (99) = happyShift action_34
action_92 (6) = happyGoto action_5
action_92 (7) = happyGoto action_6
action_92 (8) = happyGoto action_7
action_92 (35) = happyGoto action_119
action_92 (36) = happyGoto action_79
action_92 (37) = happyGoto action_20
action_92 (38) = happyGoto action_21
action_92 (42) = happyGoto action_23
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (48) = happyShift action_25
action_93 (52) = happyShift action_26
action_93 (56) = happyShift action_27
action_93 (74) = happyShift action_28
action_93 (78) = happyShift action_29
action_93 (80) = happyShift action_30
action_93 (97) = happyShift action_4
action_93 (98) = happyShift action_33
action_93 (99) = happyShift action_34
action_93 (6) = happyGoto action_5
action_93 (7) = happyGoto action_6
action_93 (8) = happyGoto action_7
action_93 (35) = happyGoto action_118
action_93 (36) = happyGoto action_79
action_93 (37) = happyGoto action_20
action_93 (38) = happyGoto action_21
action_93 (42) = happyGoto action_23
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (48) = happyShift action_25
action_94 (52) = happyShift action_26
action_94 (56) = happyShift action_27
action_94 (74) = happyShift action_28
action_94 (78) = happyShift action_29
action_94 (80) = happyShift action_30
action_94 (97) = happyShift action_4
action_94 (98) = happyShift action_33
action_94 (99) = happyShift action_34
action_94 (6) = happyGoto action_5
action_94 (7) = happyGoto action_6
action_94 (8) = happyGoto action_7
action_94 (35) = happyGoto action_117
action_94 (36) = happyGoto action_79
action_94 (37) = happyGoto action_20
action_94 (38) = happyGoto action_21
action_94 (42) = happyGoto action_23
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (48) = happyShift action_25
action_95 (52) = happyShift action_26
action_95 (56) = happyShift action_27
action_95 (74) = happyShift action_28
action_95 (78) = happyShift action_29
action_95 (80) = happyShift action_30
action_95 (97) = happyShift action_4
action_95 (98) = happyShift action_33
action_95 (99) = happyShift action_34
action_95 (6) = happyGoto action_5
action_95 (7) = happyGoto action_6
action_95 (8) = happyGoto action_7
action_95 (34) = happyGoto action_116
action_95 (35) = happyGoto action_18
action_95 (36) = happyGoto action_79
action_95 (37) = happyGoto action_20
action_95 (38) = happyGoto action_21
action_95 (42) = happyGoto action_23
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (48) = happyShift action_25
action_96 (52) = happyShift action_26
action_96 (56) = happyShift action_27
action_96 (74) = happyShift action_28
action_96 (78) = happyShift action_29
action_96 (80) = happyShift action_30
action_96 (97) = happyShift action_4
action_96 (98) = happyShift action_33
action_96 (99) = happyShift action_34
action_96 (6) = happyGoto action_5
action_96 (7) = happyGoto action_6
action_96 (8) = happyGoto action_7
action_96 (34) = happyGoto action_115
action_96 (35) = happyGoto action_18
action_96 (36) = happyGoto action_79
action_96 (37) = happyGoto action_20
action_96 (38) = happyGoto action_21
action_96 (42) = happyGoto action_23
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (48) = happyShift action_25
action_97 (52) = happyShift action_26
action_97 (56) = happyShift action_27
action_97 (74) = happyShift action_28
action_97 (78) = happyShift action_29
action_97 (80) = happyShift action_30
action_97 (97) = happyShift action_4
action_97 (98) = happyShift action_33
action_97 (99) = happyShift action_34
action_97 (6) = happyGoto action_5
action_97 (7) = happyGoto action_6
action_97 (8) = happyGoto action_7
action_97 (33) = happyGoto action_114
action_97 (34) = happyGoto action_17
action_97 (35) = happyGoto action_18
action_97 (36) = happyGoto action_79
action_97 (37) = happyGoto action_20
action_97 (38) = happyGoto action_21
action_97 (42) = happyGoto action_23
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (48) = happyShift action_25
action_98 (52) = happyShift action_26
action_98 (56) = happyShift action_27
action_98 (74) = happyShift action_28
action_98 (78) = happyShift action_29
action_98 (80) = happyShift action_30
action_98 (97) = happyShift action_4
action_98 (98) = happyShift action_33
action_98 (99) = happyShift action_34
action_98 (6) = happyGoto action_5
action_98 (7) = happyGoto action_6
action_98 (8) = happyGoto action_7
action_98 (33) = happyGoto action_113
action_98 (34) = happyGoto action_17
action_98 (35) = happyGoto action_18
action_98 (36) = happyGoto action_79
action_98 (37) = happyGoto action_20
action_98 (38) = happyGoto action_21
action_98 (42) = happyGoto action_23
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (48) = happyShift action_25
action_99 (52) = happyShift action_26
action_99 (56) = happyShift action_27
action_99 (74) = happyShift action_28
action_99 (78) = happyShift action_29
action_99 (80) = happyShift action_30
action_99 (97) = happyShift action_4
action_99 (98) = happyShift action_33
action_99 (99) = happyShift action_34
action_99 (6) = happyGoto action_5
action_99 (7) = happyGoto action_6
action_99 (8) = happyGoto action_7
action_99 (33) = happyGoto action_112
action_99 (34) = happyGoto action_17
action_99 (35) = happyGoto action_18
action_99 (36) = happyGoto action_79
action_99 (37) = happyGoto action_20
action_99 (38) = happyGoto action_21
action_99 (42) = happyGoto action_23
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (48) = happyShift action_25
action_100 (52) = happyShift action_26
action_100 (56) = happyShift action_27
action_100 (74) = happyShift action_28
action_100 (78) = happyShift action_29
action_100 (80) = happyShift action_30
action_100 (97) = happyShift action_4
action_100 (98) = happyShift action_33
action_100 (99) = happyShift action_34
action_100 (6) = happyGoto action_5
action_100 (7) = happyGoto action_6
action_100 (8) = happyGoto action_7
action_100 (33) = happyGoto action_111
action_100 (34) = happyGoto action_17
action_100 (35) = happyGoto action_18
action_100 (36) = happyGoto action_79
action_100 (37) = happyGoto action_20
action_100 (38) = happyGoto action_21
action_100 (42) = happyGoto action_23
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (48) = happyShift action_25
action_101 (52) = happyShift action_26
action_101 (56) = happyShift action_27
action_101 (74) = happyShift action_28
action_101 (78) = happyShift action_29
action_101 (80) = happyShift action_30
action_101 (97) = happyShift action_4
action_101 (98) = happyShift action_33
action_101 (99) = happyShift action_34
action_101 (6) = happyGoto action_5
action_101 (7) = happyGoto action_6
action_101 (8) = happyGoto action_7
action_101 (32) = happyGoto action_110
action_101 (33) = happyGoto action_16
action_101 (34) = happyGoto action_17
action_101 (35) = happyGoto action_18
action_101 (36) = happyGoto action_79
action_101 (37) = happyGoto action_20
action_101 (38) = happyGoto action_21
action_101 (42) = happyGoto action_23
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (48) = happyShift action_25
action_102 (52) = happyShift action_26
action_102 (56) = happyShift action_27
action_102 (74) = happyShift action_28
action_102 (78) = happyShift action_29
action_102 (80) = happyShift action_30
action_102 (97) = happyShift action_4
action_102 (98) = happyShift action_33
action_102 (99) = happyShift action_34
action_102 (6) = happyGoto action_5
action_102 (7) = happyGoto action_6
action_102 (8) = happyGoto action_7
action_102 (32) = happyGoto action_109
action_102 (33) = happyGoto action_16
action_102 (34) = happyGoto action_17
action_102 (35) = happyGoto action_18
action_102 (36) = happyGoto action_79
action_102 (37) = happyGoto action_20
action_102 (38) = happyGoto action_21
action_102 (42) = happyGoto action_23
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (48) = happyShift action_25
action_103 (52) = happyShift action_26
action_103 (56) = happyShift action_27
action_103 (74) = happyShift action_28
action_103 (78) = happyShift action_29
action_103 (80) = happyShift action_30
action_103 (90) = happyShift action_32
action_103 (97) = happyShift action_4
action_103 (98) = happyShift action_33
action_103 (99) = happyShift action_34
action_103 (6) = happyGoto action_5
action_103 (7) = happyGoto action_6
action_103 (8) = happyGoto action_7
action_103 (30) = happyGoto action_108
action_103 (31) = happyGoto action_14
action_103 (32) = happyGoto action_15
action_103 (33) = happyGoto action_16
action_103 (34) = happyGoto action_17
action_103 (35) = happyGoto action_18
action_103 (36) = happyGoto action_79
action_103 (37) = happyGoto action_20
action_103 (38) = happyGoto action_21
action_103 (42) = happyGoto action_23
action_103 (43) = happyGoto action_24
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (48) = happyShift action_25
action_104 (52) = happyShift action_26
action_104 (56) = happyShift action_27
action_104 (74) = happyShift action_28
action_104 (78) = happyShift action_29
action_104 (80) = happyShift action_30
action_104 (89) = happyShift action_31
action_104 (90) = happyShift action_32
action_104 (97) = happyShift action_4
action_104 (98) = happyShift action_33
action_104 (99) = happyShift action_34
action_104 (6) = happyGoto action_5
action_104 (7) = happyGoto action_6
action_104 (8) = happyGoto action_7
action_104 (25) = happyGoto action_107
action_104 (26) = happyGoto action_9
action_104 (27) = happyGoto action_10
action_104 (28) = happyGoto action_11
action_104 (29) = happyGoto action_12
action_104 (30) = happyGoto action_13
action_104 (31) = happyGoto action_14
action_104 (32) = happyGoto action_15
action_104 (33) = happyGoto action_16
action_104 (34) = happyGoto action_17
action_104 (35) = happyGoto action_18
action_104 (36) = happyGoto action_19
action_104 (37) = happyGoto action_20
action_104 (38) = happyGoto action_21
action_104 (41) = happyGoto action_22
action_104 (42) = happyGoto action_23
action_104 (43) = happyGoto action_24
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (48) = happyShift action_25
action_105 (52) = happyShift action_26
action_105 (56) = happyShift action_27
action_105 (74) = happyShift action_28
action_105 (78) = happyShift action_29
action_105 (80) = happyShift action_30
action_105 (90) = happyShift action_32
action_105 (97) = happyShift action_4
action_105 (98) = happyShift action_33
action_105 (99) = happyShift action_34
action_105 (6) = happyGoto action_5
action_105 (7) = happyGoto action_6
action_105 (8) = happyGoto action_7
action_105 (29) = happyGoto action_106
action_105 (30) = happyGoto action_13
action_105 (31) = happyGoto action_14
action_105 (32) = happyGoto action_15
action_105 (33) = happyGoto action_16
action_105 (34) = happyGoto action_17
action_105 (35) = happyGoto action_18
action_105 (36) = happyGoto action_79
action_105 (37) = happyGoto action_20
action_105 (38) = happyGoto action_21
action_105 (42) = happyGoto action_23
action_105 (43) = happyGoto action_24
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (82) = happyShift action_103
action_106 _ = happyReduce_56

action_107 (62) = happyShift action_163
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_58

action_109 (65) = happyShift action_97
action_109 (66) = happyShift action_98
action_109 (69) = happyShift action_99
action_109 (70) = happyShift action_100
action_109 _ = happyReduce_62

action_110 (65) = happyShift action_97
action_110 (66) = happyShift action_98
action_110 (69) = happyShift action_99
action_110 (70) = happyShift action_100
action_110 _ = happyReduce_63

action_111 (52) = happyShift action_95
action_111 (56) = happyShift action_96
action_111 _ = happyReduce_68

action_112 (52) = happyShift action_95
action_112 (56) = happyShift action_96
action_112 _ = happyReduce_66

action_113 (52) = happyShift action_95
action_113 (56) = happyShift action_96
action_113 _ = happyReduce_67

action_114 (52) = happyShift action_95
action_114 (56) = happyShift action_96
action_114 _ = happyReduce_65

action_115 (46) = happyShift action_92
action_115 (50) = happyShift action_93
action_115 (60) = happyShift action_94
action_115 _ = happyReduce_71

action_116 (46) = happyShift action_92
action_116 (50) = happyShift action_93
action_116 (60) = happyShift action_94
action_116 _ = happyReduce_70

action_117 _ = happyReduce_74

action_118 _ = happyReduce_73

action_119 _ = happyReduce_75

action_120 (52) = happyShift action_95
action_120 (55) = happyShift action_161
action_120 (56) = happyShift action_96
action_120 (81) = happyShift action_162
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (81) = happyShift action_160
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (49) = happyShift action_159
action_122 _ = happyFail (happyExpListPerState 122)

action_123 _ = happyReduce_52

action_124 _ = happyReduce_88

action_125 _ = happyReduce_77

action_126 (48) = happyShift action_25
action_126 (52) = happyShift action_26
action_126 (56) = happyShift action_27
action_126 (74) = happyShift action_28
action_126 (78) = happyShift action_29
action_126 (80) = happyShift action_30
action_126 (89) = happyShift action_31
action_126 (90) = happyShift action_32
action_126 (97) = happyShift action_4
action_126 (98) = happyShift action_33
action_126 (99) = happyShift action_34
action_126 (6) = happyGoto action_5
action_126 (7) = happyGoto action_6
action_126 (8) = happyGoto action_7
action_126 (25) = happyGoto action_75
action_126 (26) = happyGoto action_9
action_126 (27) = happyGoto action_10
action_126 (28) = happyGoto action_11
action_126 (29) = happyGoto action_12
action_126 (30) = happyGoto action_13
action_126 (31) = happyGoto action_14
action_126 (32) = happyGoto action_15
action_126 (33) = happyGoto action_16
action_126 (34) = happyGoto action_17
action_126 (35) = happyGoto action_18
action_126 (36) = happyGoto action_19
action_126 (37) = happyGoto action_20
action_126 (38) = happyGoto action_21
action_126 (39) = happyGoto action_158
action_126 (41) = happyGoto action_22
action_126 (42) = happyGoto action_23
action_126 (43) = happyGoto action_24
action_126 _ = happyReduce_93

action_127 (48) = happyShift action_25
action_127 (52) = happyShift action_26
action_127 (56) = happyShift action_27
action_127 (74) = happyShift action_28
action_127 (78) = happyShift action_29
action_127 (80) = happyShift action_30
action_127 (89) = happyShift action_31
action_127 (90) = happyShift action_32
action_127 (97) = happyShift action_4
action_127 (98) = happyShift action_33
action_127 (99) = happyShift action_34
action_127 (6) = happyGoto action_5
action_127 (7) = happyGoto action_6
action_127 (8) = happyGoto action_7
action_127 (25) = happyGoto action_157
action_127 (26) = happyGoto action_9
action_127 (27) = happyGoto action_10
action_127 (28) = happyGoto action_11
action_127 (29) = happyGoto action_12
action_127 (30) = happyGoto action_13
action_127 (31) = happyGoto action_14
action_127 (32) = happyGoto action_15
action_127 (33) = happyGoto action_16
action_127 (34) = happyGoto action_17
action_127 (35) = happyGoto action_18
action_127 (36) = happyGoto action_19
action_127 (37) = happyGoto action_20
action_127 (38) = happyGoto action_21
action_127 (41) = happyGoto action_22
action_127 (42) = happyGoto action_23
action_127 (43) = happyGoto action_24
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (97) = happyShift action_4
action_128 (6) = happyGoto action_66
action_128 (12) = happyGoto action_73
action_128 (13) = happyGoto action_156
action_128 _ = happyReduce_17

action_129 (59) = happyShift action_155
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (59) = happyReduce_31
action_130 _ = happyReduce_16

action_131 _ = happyReduce_22

action_132 (48) = happyShift action_132
action_132 (72) = happyShift action_133
action_132 (73) = happyShift action_134
action_132 (75) = happyShift action_135
action_132 (76) = happyShift action_136
action_132 (77) = happyShift action_137
action_132 (79) = happyShift action_138
action_132 (80) = happyShift action_139
action_132 (14) = happyGoto action_153
action_132 (15) = happyGoto action_154
action_132 (16) = happyGoto action_131
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_27

action_134 _ = happyReduce_25

action_135 _ = happyReduce_24

action_136 _ = happyReduce_28

action_137 _ = happyReduce_26

action_138 _ = happyReduce_20

action_139 (48) = happyShift action_132
action_139 (72) = happyShift action_133
action_139 (73) = happyShift action_134
action_139 (75) = happyShift action_135
action_139 (76) = happyShift action_136
action_139 (77) = happyShift action_137
action_139 (79) = happyShift action_138
action_139 (80) = happyShift action_139
action_139 (14) = happyGoto action_129
action_139 (15) = happyGoto action_152
action_139 (16) = happyGoto action_131
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (97) = happyShift action_4
action_140 (6) = happyGoto action_66
action_140 (12) = happyGoto action_73
action_140 (13) = happyGoto action_151
action_140 _ = happyReduce_17

action_141 (48) = happyShift action_25
action_141 (52) = happyShift action_26
action_141 (56) = happyShift action_27
action_141 (62) = happyShift action_150
action_141 (74) = happyShift action_28
action_141 (78) = happyShift action_29
action_141 (80) = happyShift action_30
action_141 (89) = happyShift action_31
action_141 (90) = happyShift action_32
action_141 (97) = happyShift action_4
action_141 (98) = happyShift action_33
action_141 (99) = happyShift action_34
action_141 (6) = happyGoto action_5
action_141 (7) = happyGoto action_6
action_141 (8) = happyGoto action_7
action_141 (25) = happyGoto action_149
action_141 (26) = happyGoto action_9
action_141 (27) = happyGoto action_10
action_141 (28) = happyGoto action_11
action_141 (29) = happyGoto action_12
action_141 (30) = happyGoto action_13
action_141 (31) = happyGoto action_14
action_141 (32) = happyGoto action_15
action_141 (33) = happyGoto action_16
action_141 (34) = happyGoto action_17
action_141 (35) = happyGoto action_18
action_141 (36) = happyGoto action_19
action_141 (37) = happyGoto action_20
action_141 (38) = happyGoto action_21
action_141 (41) = happyGoto action_22
action_141 (42) = happyGoto action_23
action_141 (43) = happyGoto action_24
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (48) = happyShift action_25
action_142 (52) = happyShift action_26
action_142 (56) = happyShift action_27
action_142 (64) = happyShift action_46
action_142 (74) = happyShift action_28
action_142 (78) = happyShift action_29
action_142 (80) = happyShift action_30
action_142 (83) = happyShift action_47
action_142 (84) = happyShift action_48
action_142 (85) = happyShift action_49
action_142 (87) = happyShift action_50
action_142 (88) = happyShift action_51
action_142 (89) = happyShift action_31
action_142 (90) = happyShift action_32
action_142 (92) = happyShift action_52
action_142 (93) = happyShift action_53
action_142 (94) = happyShift action_54
action_142 (95) = happyShift action_55
action_142 (97) = happyShift action_4
action_142 (98) = happyShift action_33
action_142 (99) = happyShift action_34
action_142 (6) = happyGoto action_35
action_142 (7) = happyGoto action_6
action_142 (8) = happyGoto action_7
action_142 (10) = happyGoto action_148
action_142 (12) = happyGoto action_37
action_142 (17) = happyGoto action_38
action_142 (19) = happyGoto action_39
action_142 (20) = happyGoto action_40
action_142 (21) = happyGoto action_41
action_142 (22) = happyGoto action_42
action_142 (23) = happyGoto action_43
action_142 (24) = happyGoto action_44
action_142 (25) = happyGoto action_45
action_142 (26) = happyGoto action_9
action_142 (27) = happyGoto action_10
action_142 (28) = happyGoto action_11
action_142 (29) = happyGoto action_12
action_142 (30) = happyGoto action_13
action_142 (31) = happyGoto action_14
action_142 (32) = happyGoto action_15
action_142 (33) = happyGoto action_16
action_142 (34) = happyGoto action_17
action_142 (35) = happyGoto action_18
action_142 (36) = happyGoto action_19
action_142 (37) = happyGoto action_20
action_142 (38) = happyGoto action_21
action_142 (41) = happyGoto action_22
action_142 (42) = happyGoto action_23
action_142 (43) = happyGoto action_24
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_49

action_144 _ = happyReduce_47

action_145 (48) = happyShift action_25
action_145 (52) = happyShift action_26
action_145 (56) = happyShift action_27
action_145 (64) = happyShift action_46
action_145 (74) = happyShift action_28
action_145 (78) = happyShift action_29
action_145 (80) = happyShift action_30
action_145 (83) = happyShift action_47
action_145 (84) = happyShift action_48
action_145 (85) = happyShift action_49
action_145 (87) = happyShift action_50
action_145 (88) = happyShift action_51
action_145 (89) = happyShift action_31
action_145 (90) = happyShift action_32
action_145 (92) = happyShift action_52
action_145 (93) = happyShift action_53
action_145 (94) = happyShift action_54
action_145 (95) = happyShift action_55
action_145 (97) = happyShift action_4
action_145 (98) = happyShift action_33
action_145 (99) = happyShift action_34
action_145 (6) = happyGoto action_35
action_145 (7) = happyGoto action_6
action_145 (8) = happyGoto action_7
action_145 (10) = happyGoto action_147
action_145 (12) = happyGoto action_37
action_145 (17) = happyGoto action_38
action_145 (19) = happyGoto action_39
action_145 (20) = happyGoto action_40
action_145 (21) = happyGoto action_41
action_145 (22) = happyGoto action_42
action_145 (23) = happyGoto action_43
action_145 (24) = happyGoto action_44
action_145 (25) = happyGoto action_45
action_145 (26) = happyGoto action_9
action_145 (27) = happyGoto action_10
action_145 (28) = happyGoto action_11
action_145 (29) = happyGoto action_12
action_145 (30) = happyGoto action_13
action_145 (31) = happyGoto action_14
action_145 (32) = happyGoto action_15
action_145 (33) = happyGoto action_16
action_145 (34) = happyGoto action_17
action_145 (35) = happyGoto action_18
action_145 (36) = happyGoto action_19
action_145 (37) = happyGoto action_20
action_145 (38) = happyGoto action_21
action_145 (41) = happyGoto action_22
action_145 (42) = happyGoto action_23
action_145 (43) = happyGoto action_24
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_37

action_147 _ = happyReduce_38

action_148 (86) = happyShift action_174
action_148 _ = happyReduce_43

action_149 (62) = happyShift action_173
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (48) = happyShift action_25
action_150 (52) = happyShift action_26
action_150 (56) = happyShift action_27
action_150 (64) = happyShift action_46
action_150 (74) = happyShift action_28
action_150 (78) = happyShift action_29
action_150 (80) = happyShift action_30
action_150 (83) = happyShift action_47
action_150 (84) = happyShift action_48
action_150 (85) = happyShift action_49
action_150 (87) = happyShift action_50
action_150 (88) = happyShift action_51
action_150 (89) = happyShift action_31
action_150 (90) = happyShift action_32
action_150 (92) = happyShift action_52
action_150 (93) = happyShift action_53
action_150 (94) = happyShift action_54
action_150 (95) = happyShift action_55
action_150 (97) = happyShift action_4
action_150 (98) = happyShift action_33
action_150 (99) = happyShift action_34
action_150 (6) = happyGoto action_35
action_150 (7) = happyGoto action_6
action_150 (8) = happyGoto action_7
action_150 (10) = happyGoto action_172
action_150 (12) = happyGoto action_37
action_150 (17) = happyGoto action_38
action_150 (19) = happyGoto action_39
action_150 (20) = happyGoto action_40
action_150 (21) = happyGoto action_41
action_150 (22) = happyGoto action_42
action_150 (23) = happyGoto action_43
action_150 (24) = happyGoto action_44
action_150 (25) = happyGoto action_45
action_150 (26) = happyGoto action_9
action_150 (27) = happyGoto action_10
action_150 (28) = happyGoto action_11
action_150 (29) = happyGoto action_12
action_150 (30) = happyGoto action_13
action_150 (31) = happyGoto action_14
action_150 (32) = happyGoto action_15
action_150 (33) = happyGoto action_16
action_150 (34) = happyGoto action_17
action_150 (35) = happyGoto action_18
action_150 (36) = happyGoto action_19
action_150 (37) = happyGoto action_20
action_150 (38) = happyGoto action_21
action_150 (41) = happyGoto action_22
action_150 (42) = happyGoto action_23
action_150 (43) = happyGoto action_24
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (49) = happyShift action_171
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (81) = happyShift action_170
action_152 _ = happyReduce_31

action_153 (49) = happyShift action_168
action_153 (59) = happyShift action_169
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_31

action_155 (48) = happyShift action_132
action_155 (72) = happyShift action_133
action_155 (73) = happyShift action_134
action_155 (75) = happyShift action_135
action_155 (76) = happyShift action_136
action_155 (77) = happyShift action_137
action_155 (79) = happyShift action_138
action_155 (80) = happyShift action_139
action_155 (14) = happyGoto action_167
action_155 (15) = happyGoto action_154
action_155 (16) = happyGoto action_131
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_19

action_157 _ = happyReduce_50

action_158 _ = happyReduce_95

action_159 _ = happyReduce_82

action_160 _ = happyReduce_84

action_161 (48) = happyShift action_25
action_161 (52) = happyShift action_26
action_161 (56) = happyShift action_27
action_161 (74) = happyShift action_28
action_161 (78) = happyShift action_29
action_161 (80) = happyShift action_30
action_161 (97) = happyShift action_4
action_161 (98) = happyShift action_33
action_161 (99) = happyShift action_34
action_161 (6) = happyGoto action_5
action_161 (7) = happyGoto action_6
action_161 (8) = happyGoto action_7
action_161 (33) = happyGoto action_165
action_161 (34) = happyGoto action_17
action_161 (35) = happyGoto action_18
action_161 (36) = happyGoto action_79
action_161 (37) = happyGoto action_20
action_161 (38) = happyGoto action_21
action_161 (40) = happyGoto action_166
action_161 (42) = happyGoto action_23
action_161 _ = happyReduce_96

action_162 _ = happyReduce_83

action_163 (48) = happyShift action_25
action_163 (52) = happyShift action_26
action_163 (56) = happyShift action_27
action_163 (74) = happyShift action_28
action_163 (78) = happyShift action_29
action_163 (80) = happyShift action_30
action_163 (90) = happyShift action_32
action_163 (97) = happyShift action_4
action_163 (98) = happyShift action_33
action_163 (99) = happyShift action_34
action_163 (6) = happyGoto action_5
action_163 (7) = happyGoto action_6
action_163 (8) = happyGoto action_7
action_163 (27) = happyGoto action_164
action_163 (28) = happyGoto action_11
action_163 (29) = happyGoto action_12
action_163 (30) = happyGoto action_13
action_163 (31) = happyGoto action_14
action_163 (32) = happyGoto action_15
action_163 (33) = happyGoto action_16
action_163 (34) = happyGoto action_17
action_163 (35) = happyGoto action_18
action_163 (36) = happyGoto action_79
action_163 (37) = happyGoto action_20
action_163 (38) = happyGoto action_21
action_163 (42) = happyGoto action_23
action_163 (43) = happyGoto action_24
action_163 _ = happyFail (happyExpListPerState 163)

action_164 _ = happyReduce_54

action_165 (52) = happyShift action_95
action_165 (55) = happyShift action_161
action_165 (56) = happyShift action_96
action_165 _ = happyReduce_97

action_166 _ = happyReduce_98

action_167 (59) = happyShift action_155
action_167 _ = happyReduce_29

action_168 _ = happyReduce_30

action_169 (48) = happyShift action_132
action_169 (72) = happyShift action_133
action_169 (73) = happyShift action_134
action_169 (75) = happyShift action_135
action_169 (76) = happyShift action_136
action_169 (77) = happyShift action_137
action_169 (79) = happyShift action_138
action_169 (80) = happyShift action_139
action_169 (14) = happyGoto action_178
action_169 (15) = happyGoto action_154
action_169 (16) = happyGoto action_131
action_169 _ = happyFail (happyExpListPerState 169)

action_170 _ = happyReduce_23

action_171 (62) = happyShift action_177
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_40

action_173 (48) = happyShift action_25
action_173 (52) = happyShift action_26
action_173 (56) = happyShift action_27
action_173 (64) = happyShift action_46
action_173 (74) = happyShift action_28
action_173 (78) = happyShift action_29
action_173 (80) = happyShift action_30
action_173 (83) = happyShift action_47
action_173 (84) = happyShift action_48
action_173 (85) = happyShift action_49
action_173 (87) = happyShift action_50
action_173 (88) = happyShift action_51
action_173 (89) = happyShift action_31
action_173 (90) = happyShift action_32
action_173 (92) = happyShift action_52
action_173 (93) = happyShift action_53
action_173 (94) = happyShift action_54
action_173 (95) = happyShift action_55
action_173 (97) = happyShift action_4
action_173 (98) = happyShift action_33
action_173 (99) = happyShift action_34
action_173 (6) = happyGoto action_35
action_173 (7) = happyGoto action_6
action_173 (8) = happyGoto action_7
action_173 (10) = happyGoto action_176
action_173 (12) = happyGoto action_37
action_173 (17) = happyGoto action_38
action_173 (19) = happyGoto action_39
action_173 (20) = happyGoto action_40
action_173 (21) = happyGoto action_41
action_173 (22) = happyGoto action_42
action_173 (23) = happyGoto action_43
action_173 (24) = happyGoto action_44
action_173 (25) = happyGoto action_45
action_173 (26) = happyGoto action_9
action_173 (27) = happyGoto action_10
action_173 (28) = happyGoto action_11
action_173 (29) = happyGoto action_12
action_173 (30) = happyGoto action_13
action_173 (31) = happyGoto action_14
action_173 (32) = happyGoto action_15
action_173 (33) = happyGoto action_16
action_173 (34) = happyGoto action_17
action_173 (35) = happyGoto action_18
action_173 (36) = happyGoto action_19
action_173 (37) = happyGoto action_20
action_173 (38) = happyGoto action_21
action_173 (41) = happyGoto action_22
action_173 (42) = happyGoto action_23
action_173 (43) = happyGoto action_24
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (62) = happyShift action_175
action_174 _ = happyFail (happyExpListPerState 174)

action_175 (48) = happyShift action_25
action_175 (52) = happyShift action_26
action_175 (56) = happyShift action_27
action_175 (64) = happyShift action_46
action_175 (74) = happyShift action_28
action_175 (78) = happyShift action_29
action_175 (80) = happyShift action_30
action_175 (83) = happyShift action_47
action_175 (84) = happyShift action_48
action_175 (85) = happyShift action_49
action_175 (87) = happyShift action_50
action_175 (88) = happyShift action_51
action_175 (89) = happyShift action_31
action_175 (90) = happyShift action_32
action_175 (92) = happyShift action_52
action_175 (93) = happyShift action_53
action_175 (94) = happyShift action_54
action_175 (95) = happyShift action_55
action_175 (97) = happyShift action_4
action_175 (98) = happyShift action_33
action_175 (99) = happyShift action_34
action_175 (6) = happyGoto action_35
action_175 (7) = happyGoto action_6
action_175 (8) = happyGoto action_7
action_175 (10) = happyGoto action_181
action_175 (12) = happyGoto action_37
action_175 (17) = happyGoto action_38
action_175 (19) = happyGoto action_39
action_175 (20) = happyGoto action_40
action_175 (21) = happyGoto action_41
action_175 (22) = happyGoto action_42
action_175 (23) = happyGoto action_43
action_175 (24) = happyGoto action_44
action_175 (25) = happyGoto action_45
action_175 (26) = happyGoto action_9
action_175 (27) = happyGoto action_10
action_175 (28) = happyGoto action_11
action_175 (29) = happyGoto action_12
action_175 (30) = happyGoto action_13
action_175 (31) = happyGoto action_14
action_175 (32) = happyGoto action_15
action_175 (33) = happyGoto action_16
action_175 (34) = happyGoto action_17
action_175 (35) = happyGoto action_18
action_175 (36) = happyGoto action_19
action_175 (37) = happyGoto action_20
action_175 (38) = happyGoto action_21
action_175 (41) = happyGoto action_22
action_175 (42) = happyGoto action_23
action_175 (43) = happyGoto action_24
action_175 _ = happyFail (happyExpListPerState 175)

action_176 _ = happyReduce_39

action_177 (48) = happyShift action_25
action_177 (52) = happyShift action_26
action_177 (56) = happyShift action_27
action_177 (64) = happyShift action_46
action_177 (74) = happyShift action_28
action_177 (78) = happyShift action_29
action_177 (80) = happyShift action_30
action_177 (83) = happyShift action_47
action_177 (84) = happyShift action_48
action_177 (85) = happyShift action_49
action_177 (87) = happyShift action_50
action_177 (88) = happyShift action_51
action_177 (89) = happyShift action_31
action_177 (90) = happyShift action_32
action_177 (92) = happyShift action_52
action_177 (93) = happyShift action_53
action_177 (94) = happyShift action_54
action_177 (95) = happyShift action_55
action_177 (97) = happyShift action_4
action_177 (98) = happyShift action_33
action_177 (99) = happyShift action_34
action_177 (6) = happyGoto action_35
action_177 (7) = happyGoto action_6
action_177 (8) = happyGoto action_7
action_177 (10) = happyGoto action_180
action_177 (12) = happyGoto action_37
action_177 (17) = happyGoto action_38
action_177 (19) = happyGoto action_39
action_177 (20) = happyGoto action_40
action_177 (21) = happyGoto action_41
action_177 (22) = happyGoto action_42
action_177 (23) = happyGoto action_43
action_177 (24) = happyGoto action_44
action_177 (25) = happyGoto action_45
action_177 (26) = happyGoto action_9
action_177 (27) = happyGoto action_10
action_177 (28) = happyGoto action_11
action_177 (29) = happyGoto action_12
action_177 (30) = happyGoto action_13
action_177 (31) = happyGoto action_14
action_177 (32) = happyGoto action_15
action_177 (33) = happyGoto action_16
action_177 (34) = happyGoto action_17
action_177 (35) = happyGoto action_18
action_177 (36) = happyGoto action_19
action_177 (37) = happyGoto action_20
action_177 (38) = happyGoto action_21
action_177 (41) = happyGoto action_22
action_177 (42) = happyGoto action_23
action_177 (43) = happyGoto action_24
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (49) = happyShift action_179
action_178 (59) = happyShift action_155
action_178 _ = happyFail (happyExpListPerState 178)

action_179 _ = happyReduce_21

action_180 _ = happyReduce_33

action_181 _ = happyReduce_44

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn6
		 (Ident happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn7
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  9 happyReduction_6
happyReduction_6 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 (AbsYmyLang.Progr (reverse happy_var_1)
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  10 happyReduction_7
happyReduction_7 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.DeclS happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  10 happyReduction_8
happyReduction_8 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.CompS happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  10 happyReduction_9
happyReduction_9 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.ExprS happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  10 happyReduction_10
happyReduction_10 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.SelS happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  10 happyReduction_11
happyReduction_11 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.IterS happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  10 happyReduction_12
happyReduction_12 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.FlowS happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn10
		 (AbsYmyLang.PrintS happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  11 happyReduction_14
happyReduction_14  =  HappyAbsSyn11
		 ([]
	)

happyReduce_15 = happySpecReduce_2  11 happyReduction_15
happyReduction_15 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  12 happyReduction_16
happyReduction_16 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn12
		 (AbsYmyLang.Declarator happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_0  13 happyReduction_17
happyReduction_17  =  HappyAbsSyn13
		 ([]
	)

happyReduce_18 = happySpecReduce_1  13 happyReduction_18
happyReduction_18 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  13 happyReduction_19
happyReduction_19 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  14 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tunit
	)

happyReduce_21 = happyReduce 5 14 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (AbsYmyLang.Tfun happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_1  14 happyReduction_22
happyReduction_22 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tarray happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  15 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tint
	)

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tbool
	)

happyReduce_26 = happySpecReduce_1  15 happyReduction_26
happyReduction_26 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tstring
	)

happyReduce_27 = happySpecReduce_1  15 happyReduction_27
happyReduction_27 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tany
	)

happyReduce_28 = happySpecReduce_1  15 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tinvalid
	)

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (AbsYmyLang.Tfunarg happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  15 happyReduction_30
happyReduction_30 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  16 happyReduction_31
happyReduction_31 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  17 happyReduction_32
happyReduction_32 _
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn17
		 (AbsYmyLang.DeclVar happy_var_1
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 7 17 happyReduction_33
happyReduction_33 ((HappyAbsSyn10  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (AbsYmyLang.DeclFn happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_0  18 happyReduction_34
happyReduction_34  =  HappyAbsSyn18
		 ([]
	)

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 ((:[]) happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  18 happyReduction_36
happyReduction_36 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn18
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  19 happyReduction_37
happyReduction_37 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (AbsYmyLang.Scomp (reverse happy_var_2)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happyReduce 4 20 happyReduction_38
happyReduction_38 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (AbsYmyLang.Swhile happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 6 20 happyReduction_39
happyReduction_39 ((HappyAbsSyn10  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_4) `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (AbsYmyLang.Sfor happy_var_2 happy_var_3 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 5 20 happyReduction_40
happyReduction_40 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	(HappyAbsSyn21  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (AbsYmyLang.Sfornoinc happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_41 = happySpecReduce_1  21 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn21
		 (AbsYmyLang.SexprEmpty
	)

happyReduce_42 = happySpecReduce_2  21 happyReduction_42
happyReduction_42 _
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn21
		 (AbsYmyLang.Sexpr happy_var_1
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happyReduce 4 22 happyReduction_43
happyReduction_43 ((HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (AbsYmyLang.Sif happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_44 = happyReduce 7 22 happyReduction_44
happyReduction_44 ((HappyAbsSyn10  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (AbsYmyLang.SifElse happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_2  23 happyReduction_45
happyReduction_45 _
	_
	 =  HappyAbsSyn23
		 (AbsYmyLang.Scontinue
	)

happyReduce_46 = happySpecReduce_2  23 happyReduction_46
happyReduction_46 _
	_
	 =  HappyAbsSyn23
		 (AbsYmyLang.Sbreak
	)

happyReduce_47 = happySpecReduce_3  23 happyReduction_47
happyReduction_47 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (AbsYmyLang.Sreturn happy_var_2
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  23 happyReduction_48
happyReduction_48 _
	_
	 =  HappyAbsSyn23
		 (AbsYmyLang.SreturnVoid
	)

happyReduce_49 = happySpecReduce_3  24 happyReduction_49
happyReduction_49 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (AbsYmyLang.Sprint happy_var_2
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happyReduce 4 25 happyReduction_50
happyReduction_50 ((HappyAbsSyn25  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsYmyLang.Elambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_51 = happySpecReduce_1  25 happyReduction_51
happyReduction_51 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  26 happyReduction_52
happyReduction_52 (HappyAbsSyn25  happy_var_3)
	(HappyAbsSyn44  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eassign happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  26 happyReduction_53
happyReduction_53 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happyReduce 5 27 happyReduction_54
happyReduction_54 ((HappyAbsSyn25  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsYmyLang.Econdition happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_1  27 happyReduction_55
happyReduction_55 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  28 happyReduction_56
happyReduction_56 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Elor happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  28 happyReduction_57
happyReduction_57 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  29 happyReduction_58
happyReduction_58 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eland happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  29 happyReduction_59
happyReduction_59 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  30 happyReduction_60
happyReduction_60 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Epreoplog happy_var_1 happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  30 happyReduction_61
happyReduction_61 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  31 happyReduction_62
happyReduction_62 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eeq happy_var_1 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  31 happyReduction_63
happyReduction_63 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eneq happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  31 happyReduction_64
happyReduction_64 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  32 happyReduction_65
happyReduction_65 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Elthen happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  32 happyReduction_66
happyReduction_66 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Egrthen happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  32 happyReduction_67
happyReduction_67 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Ele happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  32 happyReduction_68
happyReduction_68 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Ege happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  32 happyReduction_69
happyReduction_69 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  33 happyReduction_70
happyReduction_70 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eplus happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  33 happyReduction_71
happyReduction_71 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Eminus happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  33 happyReduction_72
happyReduction_72 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  34 happyReduction_73
happyReduction_73 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Etimes happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  34 happyReduction_74
happyReduction_74 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Ediv happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  34 happyReduction_75
happyReduction_75 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Emod happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  34 happyReduction_76
happyReduction_76 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  35 happyReduction_77
happyReduction_77 _
	(HappyAbsSyn39  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (AbsYmyLang.Earray happy_var_2
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_2  35 happyReduction_78
happyReduction_78 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn42  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Epreopexp happy_var_1 happy_var_2
	)
happyReduction_78 _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  35 happyReduction_79
happyReduction_79 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  36 happyReduction_80
happyReduction_80 _
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Epostinc happy_var_1
	)
happyReduction_80 _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_2  36 happyReduction_81
happyReduction_81 _
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Epostdec happy_var_1
	)
happyReduction_81 _ _  = notHappyAtAll 

happyReduce_82 = happyReduce 4 36 happyReduction_82
happyReduction_82 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsYmyLang.Efunkpar happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_83 = happyReduce 4 36 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsYmyLang.Earrayget happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_84 = happyReduce 4 36 happyReduction_84
happyReduction_84 (_ `HappyStk`
	(HappyAbsSyn39  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn25  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (AbsYmyLang.Earrgetcom happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_85 = happySpecReduce_1  36 happyReduction_85
happyReduction_85 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  37 happyReduction_86
happyReduction_86 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Evar happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  37 happyReduction_87
happyReduction_87 (HappyAbsSyn38  happy_var_1)
	 =  HappyAbsSyn25
		 (AbsYmyLang.Econst happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_3  37 happyReduction_88
happyReduction_88 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn25
		 (happy_var_2
	)
happyReduction_88 _ _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  38 happyReduction_89
happyReduction_89 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn38
		 (AbsYmyLang.Einteger happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  38 happyReduction_90
happyReduction_90 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn38
		 (AbsYmyLang.Estring happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_1  38 happyReduction_91
happyReduction_91 _
	 =  HappyAbsSyn38
		 (AbsYmyLang.Etrue
	)

happyReduce_92 = happySpecReduce_1  38 happyReduction_92
happyReduction_92 _
	 =  HappyAbsSyn38
		 (AbsYmyLang.Efalse
	)

happyReduce_93 = happySpecReduce_0  39 happyReduction_93
happyReduction_93  =  HappyAbsSyn39
		 ([]
	)

happyReduce_94 = happySpecReduce_1  39 happyReduction_94
happyReduction_94 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn39
		 ((:[]) happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_3  39 happyReduction_95
happyReduction_95 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn39
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_0  40 happyReduction_96
happyReduction_96  =  HappyAbsSyn39
		 ([]
	)

happyReduce_97 = happySpecReduce_1  40 happyReduction_97
happyReduction_97 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn39
		 ((:[]) happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_3  40 happyReduction_98
happyReduction_98 (HappyAbsSyn39  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn39
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_98 _ _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  41 happyReduction_99
happyReduction_99 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  42 happyReduction_100
happyReduction_100 _
	 =  HappyAbsSyn42
		 (AbsYmyLang.Plus
	)

happyReduce_101 = happySpecReduce_1  42 happyReduction_101
happyReduction_101 _
	 =  HappyAbsSyn42
		 (AbsYmyLang.Negative
	)

happyReduce_102 = happySpecReduce_1  43 happyReduction_102
happyReduction_102 _
	 =  HappyAbsSyn43
		 (AbsYmyLang.Logicalneg
	)

happyReduce_103 = happySpecReduce_1  44 happyReduction_103
happyReduction_103 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.Assign
	)

happyReduce_104 = happySpecReduce_1  44 happyReduction_104
happyReduction_104 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.AssignMul
	)

happyReduce_105 = happySpecReduce_1  44 happyReduction_105
happyReduction_105 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.AssignDiv
	)

happyReduce_106 = happySpecReduce_1  44 happyReduction_106
happyReduction_106 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.AssignMod
	)

happyReduce_107 = happySpecReduce_1  44 happyReduction_107
happyReduction_107 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.AssignAdd
	)

happyReduce_108 = happySpecReduce_1  44 happyReduction_108
happyReduction_108 _
	 =  HappyAbsSyn44
		 (AbsYmyLang.AssignSub
	)

happyNewToken action sts stk [] =
	action 100 100 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 45;
	PT _ (TS _ 2) -> cont 46;
	PT _ (TS _ 3) -> cont 47;
	PT _ (TS _ 4) -> cont 48;
	PT _ (TS _ 5) -> cont 49;
	PT _ (TS _ 6) -> cont 50;
	PT _ (TS _ 7) -> cont 51;
	PT _ (TS _ 8) -> cont 52;
	PT _ (TS _ 9) -> cont 53;
	PT _ (TS _ 10) -> cont 54;
	PT _ (TS _ 11) -> cont 55;
	PT _ (TS _ 12) -> cont 56;
	PT _ (TS _ 13) -> cont 57;
	PT _ (TS _ 14) -> cont 58;
	PT _ (TS _ 15) -> cont 59;
	PT _ (TS _ 16) -> cont 60;
	PT _ (TS _ 17) -> cont 61;
	PT _ (TS _ 18) -> cont 62;
	PT _ (TS _ 19) -> cont 63;
	PT _ (TS _ 20) -> cont 64;
	PT _ (TS _ 21) -> cont 65;
	PT _ (TS _ 22) -> cont 66;
	PT _ (TS _ 23) -> cont 67;
	PT _ (TS _ 24) -> cont 68;
	PT _ (TS _ 25) -> cont 69;
	PT _ (TS _ 26) -> cont 70;
	PT _ (TS _ 27) -> cont 71;
	PT _ (TS _ 28) -> cont 72;
	PT _ (TS _ 29) -> cont 73;
	PT _ (TS _ 30) -> cont 74;
	PT _ (TS _ 31) -> cont 75;
	PT _ (TS _ 32) -> cont 76;
	PT _ (TS _ 33) -> cont 77;
	PT _ (TS _ 34) -> cont 78;
	PT _ (TS _ 35) -> cont 79;
	PT _ (TS _ 36) -> cont 80;
	PT _ (TS _ 37) -> cont 81;
	PT _ (TS _ 38) -> cont 82;
	PT _ (TS _ 39) -> cont 83;
	PT _ (TS _ 40) -> cont 84;
	PT _ (TS _ 41) -> cont 85;
	PT _ (TS _ 42) -> cont 86;
	PT _ (TS _ 43) -> cont 87;
	PT _ (TS _ 44) -> cont 88;
	PT _ (TS _ 45) -> cont 89;
	PT _ (TS _ 46) -> cont 90;
	PT _ (TS _ 47) -> cont 91;
	PT _ (TS _ 48) -> cont 92;
	PT _ (TS _ 49) -> cont 93;
	PT _ (TS _ 50) -> cont 94;
	PT _ (TS _ 51) -> cont 95;
	PT _ (TS _ 52) -> cont 96;
	PT _ (TV happy_dollar_dollar) -> cont 97;
	PT _ (TI happy_dollar_dollar) -> cont 98;
	PT _ (TL happy_dollar_dollar) -> cont 99;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 100 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn9 z -> happyReturn z; _other -> notHappyAtAll })

pStmt tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

pExp tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn25 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib64/ghc-8.2.2/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghcebdc_0/ghc_2.h" #-}












































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
