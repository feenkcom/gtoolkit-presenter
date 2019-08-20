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
			spec repository: 'github://feenkcom/Bloc/src' ].
		spec package: 'GToolkit-Inspector' with: [
			spec requires: #(#Bloc) ] ].

]
