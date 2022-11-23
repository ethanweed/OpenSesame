import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')

df = pd.read_csv("/Users/ethan/Documents/GitHub/OpenSesame/Class1/class1_stims.csv")

df['correct_response'] = np.where(df['type'] == 'animal', 'a', 'f')

animals = df.loc[df['type'] == 'animal'].reset_index(drop = True)
fruitveg = df.loc[df['type'] == 'fruit_veg'].reset_index(drop = True)

animals1 = animals.iloc[0:60]
animals2 = animals.iloc[60:120]

fruitveg1 = fruitveg.iloc[0:60]
fruitveg2 = fruitveg.iloc[60:120]

animals_inde = animals.loc[animals['condition'] == 'identical']
animals_semi = animals.loc[animals['condition'] == 'semi-scrambled']
animals_full = animals.loc[animals['condition'] == 'fully-scrambled']

fruitveg_inde = fruitveg.loc[fruitveg['condition'] == 'identical']
fruitveg_semi = fruitveg.loc[fruitveg['condition'] == 'semi-scrambled']
fruitveg_full = fruitveg.loc[fruitveg['condition'] == 'fully-scrambled']

animals_inde1 = animals_inde.iloc[::3, :]
animals_inde2 = animals_inde.iloc[1::3, :]
animals_inde3 = animals_inde.iloc[2::3, :]

fruitveg_inde1 = fruitveg_inde.iloc[::3, :]
fruitveg_inde2 = fruitveg_inde.iloc[1::3, :]
fruitveg_inde3 = fruitveg_inde.iloc[2::3, :]

animals_semi1 = animals_semi.iloc[::3, :]
animals_semi2 = animals_semi.iloc[1::3, :]
animals_semi3 = animals_semi.iloc[2::3, :]

fruitveg_semi1 = fruitveg_semi.iloc[::3, :]
fruitveg_semi2 = fruitveg_semi.iloc[1::3, :]
fruitveg_semi3 = fruitveg_semi.iloc[2::3, :]

animals_full1 = animals_full.iloc[::3, :]
animals_full2 = animals_full.iloc[1::3, :]
animals_full3 = animals_full.iloc[2::3, :]

fruitveg1_full1 = fruitveg_full.iloc[::3, :]
fruitveg1_full2 = fruitveg_full.iloc[1::3, :]
fruitveg1_full3 = fruitveg_full.iloc[2::3, :]


stims1 = pd.concat([animals_inde1, fruitveg_inde1, animals_semi2, fruitveg_semi2, animals_full3, fruitveg1_full3])
stims2 = pd.concat([animals_inde2, fruitveg_inde2, animals_semi3, fruitveg_semi3, animals_full1, fruitveg1_full1])
stims3 = pd.concat([animals_inde3, fruitveg_inde3, animals_semi1, fruitveg_semi1, animals_full2, fruitveg1_full2])

stims1['block'] = ['block1']*len(stims1)
stims2['block'] = ['block2']*len(stims2)
stims3['block'] = ['block3']*len(stims3)


stims1.to_csv('block1.csv')
stims2.to_csv('block2.csv')
stims3.to_csv('block3.csv')