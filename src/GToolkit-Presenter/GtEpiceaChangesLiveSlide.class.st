Class {
	#name : #GtEpiceaChangesLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'changes',
		'ombuFile'
	],
	#category : 'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtEpiceaChangesLiveSlide >> changes [
	^ changes ifNil: [ changes := GtEpicea new ombuFile: self ombuFile ].
]

{ #category : #accessing }
GtEpiceaChangesLiveSlide >> create [
	| aToolbar inspectorElement inspectorContainer container |
	aToolbar := BrToolbar new
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignTop ];
		margin:
			(BlInsets
				top: 10
				right: 5
				bottom: 5
				left: 5);
		aptitude: BrGlamorousToolbarAptitude;
		addItem:
			(BrButton new
				beNormalSize;
				aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
				label: 'Apply' asString;
				icon: BrGlamorousIcons accept asElement;
				action: [ self changes applyChanges ]).
	inspectorElement := BlUseAsyncFeatures
		disableDuring: [ (GtPhlowView empty composite
				views:
					{(self changes gtDiffFor: GtPhlowView empty).
					(self changes gtTutorialFor: GtPhlowView empty)})
				asElementDo: [ :e | e ] ].
	inspectorElement forceLayout.
	inspectorContainer := BlElement new
		margin:
			(BlInsets
				top: 35
				right: 5
				bottom: 5
				left: 5);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c frame vertical alignTop ];
		addChild: inspectorElement.
	container := BlElement new
		layout: BlFrameLayout new;
		aptitude: BrShadowAptitude;
		background: Color white;
		margin:
			(BlInsets
				top: 5
				right: 30
				bottom: 5
				left: 30);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		addChildren:
			{aToolbar.
			inspectorContainer}.
	^ container
]

{ #category : #accessing }
GtEpiceaChangesLiveSlide >> fileName: aString [
	self ombuFile: aString asFileReference.
]

{ #category : #accessing }
GtEpiceaChangesLiveSlide >> ombuFile [
	^ ombuFile.
]

{ #category : #accessing }
GtEpiceaChangesLiveSlide >> ombuFile: aFileReference [
	ombuFile := aFileReference.
]
