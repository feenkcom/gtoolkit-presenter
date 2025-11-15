Class {
	#name : #GtLepiterPageLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'startPage',
		'maximized'
	],
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtLepiterPageLiveSlide >> beMaximized [
	maximized := true
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> create [
	| aPager |
	aPager := GtPagerSettings usedPager createWrappedOn: startPage asPhlowTool.
	maximized ifTrue: [ aPager maximized ].
	aPager addAptitude: BrShadowAptitude new beLarge.
	^ aPager
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> initialize [
	super initialize.
	maximized := false.
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> maximized: aBoolean [
	maximized := aBoolean
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> pageNamed: aPageName from: aLepiterBaseName [
	| database |
	database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase 
				databaseNamed: aLepiterBaseName.
	startPage := database pageNamed: aPageName.
]

{ #category : #accessing }
GtLepiterPageLiveSlide >> startPage: aLePage [
	"For dynamically created pages no associated with an actual database."

	startPage := aLePage
]
