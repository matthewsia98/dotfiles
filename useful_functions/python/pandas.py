import numpy as np


def highlight_diagonal(df, color="yellow"):
    """
    Usage:
        df.style.apply(highlight_diagonal, axis=None)
        df.style.apply(lambda x: highlight_diagonal(x, color="blue"), axis=None)
    """
    style = np.full(df.shape, None)
    np.fill_diagonal(style, f"background-color: {color}")

    return style
