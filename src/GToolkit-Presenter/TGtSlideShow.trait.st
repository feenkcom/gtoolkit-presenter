Trait {
	#name : #TGtSlideShow,
	#category : #'GToolkit-Presenter-Models - Support'
}

{ #category : #viewing }
TGtSlideShow classSide >> gtInspectSlideshowActionFor: anAction [
	<gtAction>
	<gtClassAction>
	^ anAction button
		tooltip: 'Inspect slideshow';
		priority: 10;
		id: GtPresenterPreviewShowButtonId;
		icon: BrGlamorousVectorIcons playinspect;
		action: [ :aButton | 
			aButton phlow
				spawnObject: ((self inheritsFrom: PrioritySlideshow)
						ifTrue: [ self new ]
						ifFalse: [ GtPresenterSlideShow create: self new ]) ]
]

{ #category : #viewing }
TGtSlideShow classSide >> gtLiveSlideshowFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit 
		title: 'Slideshow';
		priority: 35;
		stencil: [ GtPresenterSlideShow create: self new ];
		actionUpdateButton
]

{ #category : #accessing }
TGtSlideShow classSide >> gtOpenSlideshowActionFor: anAction [
	<gtAction>
	<gtClassAction>
	(self methods select: [ :m | m hasPragmaNamed: #gtSlide ]) isEmpty
		ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 11;
		tooltip: 'Play slideshow in new window';
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | GtPresenterSlideShow openInSpace: self ]
]

{ #category : #accessing }
TGtSlideShow >> gtLiveSlideshowFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit 
		title: 'Slideshow';
		stencil: [ GtPresenterSlideShow create: self ];
		actionUpdateButton
]

{ #category : #accessing }
TGtSlideShow >> gtSlidesFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward 
		title: 'Slides';
		object: [ GtPresenterSlideShow create: self ];
		view: #gtSlidesListViewFor:
]
