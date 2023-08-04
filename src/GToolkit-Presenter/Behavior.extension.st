Extension { #name : #Behavior }

{ #category : #'*GToolkit-Presenter' }
Behavior >> gtOpenSlideshowActionFor: anAction [
	<gtAction>
	<gtClassAction>
	(self methods select: [ :m | m hasPragmaNamed: #gtSlide ]) isEmpty
		ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 5;
		tooltip: 'Open slideshow in new window';
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | GtPresenterSlideShow openInSpace: self ]
]
