"""
Spyder Editor
This is a temporary script file.
"""
import pandas as pd 
from datetime import datetime

dailypagelimit=4

today=int(datetime.today().strftime('%Y%m%d'))

todaydata=pd.read_csv('.readingstats',sep='|',)
todaydata=todaydata[todaydata['Date']==today]

todaydata['Category']=todaydata['FileName'].apply(lambda x:x.replace('/2/Downloads/',''))
todaydata['Category']=todaydata['Category'].apply(lambda x:x.split('.')[0])
todaydata['Category']=todaydata['Category'].apply(lambda x:int(x))
todaydata=todaydata.drop(['FileName','Date'],axis=1)

todaydata1=todaydata.groupby('Category').sum().reset_index()

dic={'Category':[0,1,2,3,4,5],'Folder':['/2/Downloads/0.SelfImprovement'
     ,'/2/Downloads/1.ML'
     ,'/2/Downloads/2.Programming'
     ,'/2/Downloads/3.Investment'
     ,'/2/Downloads/4.SkillPolish'
     ,'/2/Downloads/5.Entertainment']}

folder=pd.DataFrame(dic)

i = 0
while i < 1:
	folder['dailypagelimit']=folder['Category'].apply(lambda x:(x+1)*dailypagelimit)
	final=pd.merge(folder,todaydata1,how='outer',on='Category')
	final['Pages'] = final.Pages.fillna(0)

	todaydata4=final['Category'][final['Pages']<final['dailypagelimit']].min()
	t=final['Folder'][folder['Category']==todaydata4]
	if t.count()>0:
		i = 1
	else:
		dailypagelimit=2*dailypagelimit		

t.to_csv ('.mplayer_delete_parent', index = False,header=False)
