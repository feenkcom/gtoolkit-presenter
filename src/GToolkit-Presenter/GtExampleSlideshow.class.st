Class {
	#name : #GtExampleSlideshow,
	#superclass : #GtLiveShow,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtExampleSlideshow >> elementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 20;
		element: [BlElement new background: Color red].
]

{ #category : #accessing }
GtExampleSlideshow >> textAndElementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 5;
		newTextWithFormat: (('Ana ' asRopedText, ('has' asRopedText glamorousExplanationFor: #has), ' apple' asRopedText) asRopedText glamorousRegularFont; fontSize: 20);
		element: [
			| elementA elementB |
			elementA := BlElement new
				constraintsDo: [:c |
					c vertical matchParent.
					c horizontal matchParent];
				background: Color red.
			elementB := BlElement new
				constraintsDo: [:c |
					c vertical matchParent.
					c horizontal matchParent];
				background: Color blue.
			elementA
				addChild:
					(BrButton new
						constraintsDo: [ :c | c ignoreByLayout ];
						size: 3 @ 3;
						elevation: (BlRelativeElevation elevation: 10);
						geometry: BlCircle new;
						look: (GtExplainerTargetLook new explanationModel: #has);
						relocate:
							(100 @ 100)).
			BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [:c |
					c vertical matchParent.
					c horizontal matchParent];
				addChildren: {elementA. elementB}];
		elementWeight: 0.6.
]

{ #category : #accessing }
GtExampleSlideshow >> textExampleFor: aSlide [
	<gtSlide>
	^ aSlide text
		priority: 10;
		newText: 'Something goes here' asRopedText.
]
