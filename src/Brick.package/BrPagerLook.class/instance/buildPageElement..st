instance creation
buildPageElement: aContentElement
	<return: #BlElement>
	| aPageElement aResizer |

	aPageElement := BlElement new
		look: BrShadowLook new;
		background: Color white;
		layout: BlLinearLayout vertical;
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ].

	aResizer := BlElement new
		background: Color black;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c vertical exact: 7.
			c horizontal exact: 7.
			c ignored vertical alignBottom.
			c ignored horizontal alignRight ];
		addEventHandler: (BlResizerBottomRightListener new resizeTarget: aPageElement; minimumExtent: 75@75).
		
	aPageElement addChild: aContentElement.
	aPageElement addChild: aResizer.
	
	^ aPageElement