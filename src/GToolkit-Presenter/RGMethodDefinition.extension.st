Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Presenter' }
RGMethodDefinition >> asScalableSlide [
	^ self method asScalableSlide
]

{ #category : #'*GToolkit-Presenter' }
RGMethodDefinition >> asSlide [
	^ self method asSlide
]

{ #category : #'*GToolkit-Presenter' }
RGMethodDefinition >> gtPlayAction: anAction [
	"self slides ifEmpty: [ ^ anAction empty ]."

	<gtAction>
	^ anAction explicit
		priority: 20;
		stencil: [ | button |
			button := BrButton new
					id: GtInspectorInspectButtonId;
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons play;
					action: [ :aButton :aModel :anEvent | 
						BlSpace new
							addChild: self asScalableSlide asElement;
							show ];
					label: 'Open slide in a new window'.
			button ]
]

{ #category : #'*GToolkit-Presenter' }
RGMethodDefinition >> gtSlideFor: aView [
	<gtView>
	(self method hasPragmaNamed: #gtSlide) ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Slide';
		priority: 6;
		object: [ self asScalableSlide asElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]
