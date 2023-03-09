Trait {
	#name : #TGtSlideShow,
	#category : #'GToolkit-Presenter-Models - Support'
}

{ #category : #viewing }
TGtSlideShow classSide >> gtLiveSlideshowFor: aView [
	<gtView>
	<gtClassView>
	^ aView explicit 
		title: 'Slideshow';
		stencil: [ GtPresenterSlideShow create: self new ];
		actionUpdateButton
]

{ #category : #viewing }
TGtSlideShow classSide >> gtOpenActionFor: anAction [
	<gtAction>
	<gtClassAction>
	^ anAction button 
		tooltip: 'Open slideshow';
		priority: 1;
		id: GtPresenterPreviewShowButtonId;
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | aButton phlow spawnObject: (GtPresenterSlideShow create: self new) ]
]
