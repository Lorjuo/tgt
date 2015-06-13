window.tinymceDefaults = {
    style_formats: [{
            title: 'Headers',
            items: [{
                title: 'h1',
                block: 'h1'
            }, {
                title: 'h2',
                block: 'h2'
            }, {
                title: 'h3',
                block: 'h3'
            }, {
                title: 'h4',
                block: 'h4'
            }, {
                title: 'h5',
                block: 'h5'
            }, {
                title: 'h6',
                block: 'h6'
            }]
        },

        {
            title: 'Inline',
            items: [{
                title: 'Bold',
                inline: 'b',
                icon: 'bold'
            }, {
                title: 'Italic',
                inline: 'i',
                icon: 'italic'
            }, {
                title: 'Underline',
                inline: 'span',
                styles: {
                    textDecoration: 'underline'
                },
                icon: 'underline'
            }, {
                title: 'Strikethrough',
                inline: 'span',
                styles: {
                    textDecoration: 'line-through'
                },
                icon: 'strikethrough'
            }, {
                title: 'Superscript',
                inline: 'sup',
                icon: 'superscript'
            }, {
                title: 'Subscript',
                inline: 'sub',
                icon: 'subscript'
            }, {
                title: 'Code',
                inline: 'code',
                icon: 'code'
            }, ]
        },

        {
            title: 'Blocks',
            items: [{
                title: 'Paragraph',
                block: 'p'
            }, {
                title: 'Blockquote',
                block: 'blockquote'
            }, {
                title: 'Div',
                block: 'div'
            }, {
                title: 'Pre',
                block: 'pre'
            }]
        },

        {
            title: 'Alignment',
            items: [{
                title: 'Left',
                block: 'div',
                styles: {
                    textAlign: 'left'
                },
                icon: 'alignleft'
            }, {
                title: 'Center',
                block: 'div',
                styles: {
                    textAlign: 'center'
                },
                icon: 'aligncenter'
            }, {
                title: 'Right',
                block: 'div',
                styles: {
                    textAlign: 'right'
                },
                icon: 'alignright'
            }, {
                title: 'Justify',
                block: 'div',
                styles: {
                    textAlign: 'justify'
                },
                icon: 'alignjustify'
            }]
        },

        {
            title: 'Table',
            items: [{
                title: 'Zelle',
                items: [{
                    title: 'Header',
                    selector: "th,td",
                    block: "th"
                }, {
                    title: 'Normal',
                    selector: "th,td",
                    block: "td"
                }]
            }, {
                title: 'Default Bootstrap Table',
                selector: "table",
                classes: "table"
            }, {
                title: 'Bordered',
                selector: "table",
                classes: "table table-bordered"
            }, {
                title: 'Striped',
                selector: "table",
                classes: 'table table-striped'
            }, {
                title: 'Datatable (remember to set th and thead)',
                selector: "table",
                classes: 'table datatable defaults'
            }]
        },
    ],

    fontsize_formats: "8pt 10pt 12pt 14pt 18pt 24pt 36pt",

    // TODO: Removeformat does not work for table classes
    removeformat: [{
        selector: 'table',
        remove: 'all',
        attributes: ['style', 'class'],
        split: false,
        expand: false,
        deep: true,
    }, {
        selector: 'b,strong,em,i,font,u,strike',
        remove: 'all',
        split: true,
        expand: false,
        block_expand: true,
        deep: true
    }, {
        selector: 'span',
        attributes: ['style', 'class'],
        remove: 'empty',
        split: true,
        expand: false,
        deep: true
    }, {
        selector: '*',
        attributes: ['style', 'class'],
        split: false,
        expand: false,
        deep: true
    }],
    //style_formats_merge: true // For merging new and default styles
    //verify_html : false,
    //extended_valid_elements : "div*",
    //extended_valid_elements : "div[*]",
    extended_valid_elements : "span[class]"
}