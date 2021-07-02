Class {
	#name : #BaselineOfGToolkitPresenter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitPresenter
}

{ #category : #baseline }
BaselineOfGToolkitPresenter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.210/src' ].
		spec 
			package: 'GToolkit-Presenter' with: [
				spec requires: #('Bloc' ). ];
			package: 'GToolkit-Explainer' with: [
				spec requires: #('Bloc' ). ];
			package: 'GToolkit-Presenter-Examples' with: [
				spec requires: #('GToolkit-Presenter' ). ]. ].

]
