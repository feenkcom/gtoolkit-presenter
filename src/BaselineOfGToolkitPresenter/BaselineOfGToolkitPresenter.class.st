Class {
	#name : #BaselineOfGToolkitPresenter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPresenter
}

{ #category : #baseline }
BaselineOfGToolkitPresenter >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick'
			with: [ spec repository: 'github://feenkcom/Brick:main/src' ].
		spec
			baseline: 'GToolkit4Pharo'
			with: [ spec repository: 'github://feenkcom/gt4pharo:main/src' ].

		spec
			package: 'GToolkit-Presenter'
			with: [ spec requires: #( 'Brick' ) ];
			package: 'GToolkit-Explainer'
			with: [ 
				spec requires: #( 'Brick' 'GToolkit4Pharo' 'GToolkit-Presenter' ) ];
			package: 'GToolkit-Presenter-Examples'
			with: [ spec requires: #( 'GToolkit-Presenter' ) ] ]
]
