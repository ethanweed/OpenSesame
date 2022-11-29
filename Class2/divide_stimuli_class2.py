import pandas as pd

df = pd.read_csv('/Users/ethan/Documents/GitHub/OpenSesame/Class2/stims1.csv')

# divide stimuli into natural and manmade
manmade = df.loc[df['Category'] == 'manmade']
natural = df.loc[df['Category'] == 'natural']

# divide natural and manmade stimuli into conditions
manmade_unr = manmade.loc[manmade['Mod_level'] == 'unrelated']
manmade_exa = manmade.loc[manmade['Mod_level'] == 'exact']
manmade_one = manmade.loc[manmade['Mod_level'] == 'one_modification']
manmade_two = manmade.loc[manmade['Mod_level'] == 'two_modifications']

natural_unr = natural.loc[natural['Mod_level'] == 'unrelated']
natural_exa = natural.loc[natural['Mod_level'] == 'exact']
natural_one = natural.loc[natural['Mod_level'] == 'one_modification']
natural_two = natural.loc[natural['Mod_level'] == 'two_modifications']

# select every fourth item from each dataframe
manmade_unr1 = manmade_unr.iloc[::4, :]
manmade_unr2 = manmade_unr.iloc[1::4, :]
manmade_unr3 = manmade_unr.iloc[2::4, :]
manmade_unr4 = manmade_unr.iloc[3::4, :]

manmade_exa1 = manmade_exa.iloc[::4, :]
manmade_exa2 = manmade_exa.iloc[1::4, :]
manmade_exa3 = manmade_exa.iloc[2::4, :]
manmade_exa4 = manmade_exa.iloc[3::4, :]

manmade_one1 = manmade_one.iloc[::4, :]
manmade_one2 = manmade_one.iloc[1::4, :]
manmade_one3 = manmade_one.iloc[2::4, :]
manmade_one4 = manmade_one.iloc[3::4, :]

manmade_two1 = manmade_two.iloc[::4, :]
manmade_two2 = manmade_two.iloc[1::4, :]
manmade_two3 = manmade_two.iloc[2::4, :]
manmade_two4 = manmade_two.iloc[3::4, :]

natural_unr1 = natural_unr.iloc[::4, :]
natural_unr2 = natural_unr.iloc[1::4, :]
natural_unr3 = natural_unr.iloc[2::4, :]
natural_unr4 = natural_unr.iloc[3::4, :]

natural_exa1 = natural_exa.iloc[::4, :]
natural_exa2 = natural_exa.iloc[1::4, :]
natural_exa3 = natural_exa.iloc[2::4, :]
natural_exa4 = natural_exa.iloc[3::4, :]

natural_one1 = natural_one.iloc[::4, :]
natural_one2 = natural_one.iloc[1::4, :]
natural_one3 = natural_one.iloc[2::4, :]
natural_one4 = natural_one.iloc[3::4, :]

natural_two1 = natural_two.iloc[::4, :]
natural_two2 = natural_two.iloc[1::4, :]
natural_two3 = natural_two.iloc[2::4, :]
natural_two4 = natural_two.iloc[3::4, :]

# assemble balanced blocks to avoid repeats
block1 = pd.concat([manmade_unr1, manmade_exa2, manmade_one3, manmade_two4,
                   natural_unr1, natural_exa2, natural_one3, natural_two4])
block2 = pd.concat([manmade_unr2, manmade_exa3, manmade_one4, manmade_two1,
                   natural_unr2, natural_exa3, natural_one4, natural_two1])
block3 = pd.concat([manmade_unr3, manmade_exa4, manmade_one1, manmade_two2,
                   natural_unr3, natural_exa4, natural_one1, natural_two2])
block4 = pd.concat([manmade_unr4, manmade_exa1, manmade_one2, manmade_two3,
                   natural_unr4, natural_exa1, natural_one2, natural_two3])

# add column to label block in OpensSesame
block1['Block'] = ['block1']*len(block1)
block2['Block'] = ['block2']*len(block2)
block3['Block'] = ['block3']*len(block3)
block4['Block'] = ['block4']*len(block4)

# save the stimuli to seperate files
block1.to_csv('block1.csv')
block2.to_csv('block2.csv')
block3.to_csv('block3.csv')
block4.to_csv('block4.csv')