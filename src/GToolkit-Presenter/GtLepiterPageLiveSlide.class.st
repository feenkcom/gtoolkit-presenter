Class {
	#name : #GtLepiterPageLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'startPage'
	],
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtLepiterPageLiveSlide >> create [
	startPage asPhlowTool asElementDo: [:e | 
		^ GtPager createWrappedOn: e ]
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> pageNamed: aPageName from: aLepiterBaseName [
	| database |
	database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase 
				databaseNamed: aLepiterBaseName.
	startPage := database pageNamed: aPageName.
]
