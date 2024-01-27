Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Presenter' }
RGMethodDefinition >> gtSlideFor: aView [
	<gtView>
	(self method hasPragmaNamed: #gtSlide) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Slide';
		priority: 6;
		object: [ | aSlide |
			aSlide := self method 
					valueWithReceiver: self methodClass new
					arguments: {GtProtoLiveSlide new}.
			(GtProtoLiveSlide new element
				element: [ (aSlide asElement size: 1200 @ 900) asScalableElement ])
				asElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]
