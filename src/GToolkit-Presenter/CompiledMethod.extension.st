Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asScalableSlide [
	self assert: (self hasPragmaNamed: #gtSlide) description: 'This method is only valid for slides.'.
	^ self asSlide asScalableSlide
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asScalableSlideIn: aSlideshow [
	self
		assert: (self hasPragmaNamed: #gtSlide)
		description: 'This method is only valid for slides.'.
	^ (self asSlideIn: aSlideshow) asScalableSlide
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asScalableSlideWithBorder [
	self assert: (self hasPragmaNamed: #gtSlide) description: 'This method is only valid for slides.'.
	^ self asSlide asScalableSlideWithBorder
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asScalableSlideWithBorderIn: aSlideshow [
	self
		assert: (self hasPragmaNamed: #gtSlide)
		description: 'This method is only valid for slides.'.
	^ (self asSlideIn: aSlideshow) asScalableSlideWithBorder
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asSlide [
	self assert: (self hasPragmaNamed: #gtSlide) description: 'This method is only valid for slides.'.
	^ (self method
		valueWithReceiver: self methodClass new
		arguments: {GtProtoLiveSlide new})
]

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> asSlideIn: aSlideshow [
	self
		assert: (self hasPragmaNamed: #gtSlide)
		description: 'This method is only valid for slides.'.
	^ self method valueWithReceiver: aSlideshow arguments: {GtProtoLiveSlide new}
]

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
	self assert: (self hasPragmaNamed: #gtSlide) description: 'This method is only valid for slides.'.
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
