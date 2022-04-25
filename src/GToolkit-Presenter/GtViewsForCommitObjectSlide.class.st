Class {
	#name : #GtViewsForCommitObjectSlide,
	#superclass : #GtInspectorViewsLiveSlide,
	#category : #'GToolkit-Presenter-GToolkit-Presenter'
}

{ #category : #accessing }
GtViewsForCommitObjectSlide >> create [
	| gtRepository container commit |
	gtRepository := IceRepository registry detect: [ :each | each name = 'gtoolkit' ].

	commit := gtRepository head commits detect: [:each | each id = 'da990f6795cf219b463ee2fb9c8e4973198089d5'].

	container := BlElement new
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent ];
		layout: (BlGridLayout new columnCount: 3).
	
	{
		commit. 
		commit .
		commit.
		commit.
		commit .
		commit } do: [:x | 
			container addChild: (((x gtViewsFor: GtPhlowView empty) 
				asElementDo: [:e | 
					BlElement new 
						aptitude: BrShadowAptitude; 
						background: Color white;
						margin: (BlInsets all: 20);
						addChild: e]) size: 600@400) ].
	^ container asPannableElement
]
