Class {
	#name : #BaselineOfGToolkitPresenter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPresenter
}

{ #category : #baseline }
BaselineOfGToolkitPresenter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1639/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.2363/src' ].

		spec package: 'GToolkit-Presenter' with: [
			spec requires: #(#Brick) ].
		spec package: 'GToolkit-Explainer' with: [
			spec requires: #(#Brick #GToolkit4Pharo #'GToolkit-Presenter') ].
		spec package: 'GToolkit-Presenter-Examples' with: [
			spec requires: #(#'GToolkit-Presenter') ].
	]
]
