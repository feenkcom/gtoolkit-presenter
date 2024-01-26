Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> gtSlide [
	<gtCollector>
	^ thisContext
		object: self methodClass new
		perform: self selector
		withArguments: {GtEmptySlide new}
		inClass: self methodClass.
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> gtSlideBuilder [
	^ GtSlideBuilder new
		slideShowClass: self methodClass;
		slideSelector: self selector
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> gtSlideFor: aView [
	<gtView>
	(self hasPragmaNamed: #gtSlide) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Slide';
		priority: 4;
		object: [ | aSlide |
			aSlide := self
					valueWithReceiver: self methodClass new
					arguments: {GtProtoLiveSlide new}.
			(GtProtoLiveSlide new element
				element: [ (aSlide asElement size: 1200 @ 900) asScalableElement ])
				asElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]
